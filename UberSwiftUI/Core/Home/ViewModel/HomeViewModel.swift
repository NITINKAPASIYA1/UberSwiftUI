//
//  HomeViewModel.swift
//  UberSwiftUI
//
//  Created by Nitin on 26/04/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import Combine
import MapKit

class HomeViewModel: NSObject, ObservableObject {
    
    @Published var drivers = [User]()
    @Published var trip : Trip?
    private let service = UserService.shared
    private var cancellables = Set<AnyCancellable>()
    var currentUser : User?
    var routeToPickupLocation : MKRoute?
    
    //Location search properties
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation : UberLocation?
    @Published var pickupTime : String?
    @Published var dropoffTime : String?
    private let searchCompleter = MKLocalSearchCompleter()
    @Published var queryFragment : String = "" {
        didSet{
            print("DEBUG : Query Frament is : \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    var userLocation : CLLocationCoordinate2D?
    
    
    //MARK: lifecycle
    
    override init() {
        super.init()
        fetchUser()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    //MARK: Helpers
    
    var tripCancelledMessage : String {
        guard let user = currentUser, let trip = trip else {return ""}
        
        if user.accountType == .passenger {
            if trip.state == .driverCancelled {
                return "The Driver Cancelled this Trip"
            }
            else if trip.state == .passengerCancelled {
                return "You Cancelled this Trip"
            }
        }
        else {
            if trip.state == .driverCancelled {
                return "You Cancelled this Trip"
            }
            else if trip.state == .passengerCancelled {
                return "The Driver Cancelled this Trip"
            }
        }
        return ""
    }
    
    
    
    func viewForState(_ state : MapViewState, user : User) -> some View {
        switch state {
        case .polylineAdded , .locationSelected:
            return AnyView(RideRequestView ())
        case .tripRequested:
            if user.accountType == .passenger {
                return AnyView(TripLoadingView())
            }
            else {
                if let trip = self.trip {
                    return AnyView(AcceptTripView(trip: trip))
                }
            }
        case .tripAccepted:
            if user.accountType == .passenger {
                return AnyView(TripAcceptedView())
            }
            else {
                if let trip = self.trip {
                    return AnyView(PickupPassengerView(trip: trip))
                }
            }
        case .tripCancelledByPassenger,.tripCancelledByDriver:
            return AnyView(TripCancelledView())
        default:
            break
        }
        
        return AnyView(Text(""))
    }
    
    
    //MARK: User API'S
    
    func fetchUser() {
        service.$user
            .sink { user in
                self.currentUser = user
                guard let user = user else {return }
                if user.accountType == .passenger {
                    self.fetchDrivers()
                    self.addTripObserverForPassenger()
                }else {
                    self.addTripObserverForDriver()
                }
            }
            .store(in: &cancellables)
    }
    
    private func updateTripState(state : TripState) {
        guard let trip = trip else { return }
        
        var data = ["state" : state.rawValue]
        
        if state == .accepted {
            data["travelTimeToPassenger"] =  trip.travelTimeToPassenger
        }
        
        Firestore.firestore().collection("trips").document(trip.id).updateData(data) { _ in
            print("DEBUG : Successfully updated trip state \(state)")
        }
    }
    
    func deleteTrip() {
        guard let trip = trip else { return }
        
        Firestore.firestore().collection("trips").document(trip.id).delete() { err in
            self.trip = nil
            if let err = err {
                print("Error deleting document: \(err)")
            } else {
                print("Document successfully deleted!")
            }
        }
    }
}

// MARK: Passenger API

extension HomeViewModel {
    
    func addTripObserverForPassenger() {
        guard let currentUser = self.currentUser , currentUser.accountType == .passenger else { return }
        
        Firestore.firestore().collection("trips")
            .whereField("passengerUid", isEqualTo: currentUser.uid)
            .addSnapshotListener { snapshot, _ in
                guard let change = snapshot?.documentChanges.first ,
                        change.type == .added
                        || change.type == .modified else { return }
                
                guard let trip = try? change.document.data(as: Trip.self) else {return}
                self.trip = trip
                print("DEBUG: Updated Trip state is - \(trip.state)")
            }
    }
    
    func fetchDrivers() {
        Firestore.firestore().collection("users")
            .whereField("accountType", isEqualTo: AccountType.driver.rawValue)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch drivers with error \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                
                let driver = documents.compactMap { try? $0.data(as : User.self) }
                self.drivers = driver
                print("DEBUG: Driver - \(driver)")
                
            }
    
    }
    
    func requestTrip() {
        
        guard let drivers = drivers.first else { return }
        guard let currentUser = self.currentUser else { return }
        guard let dropoffLocation = self.selectedUberLocation else { return }
        let dropoffGeoPoint = GeoPoint(latitude: dropoffLocation.coordinate.latitude, longitude: dropoffLocation.coordinate.longitude)
        let userLocation = CLLocation(latitude: currentUser.coordinates.latitude, longitude: currentUser.coordinates.longitude)
        

        
        getPlacemark(forLocation: userLocation) { placemark, error in
            
            if let error = error {
                print("DEBUG: Error in getting placemark \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemark else { return }
            print("DEBUG: Placemark is \(placemark.name ?? "")")
            
            let tripCost = self.computeRidePrice(forType: .uberX)

            let trip = Trip(
                            passengerUid: currentUser.uid,
                            driverUid: drivers.uid,
                            passengerName: currentUser.userName,
                            driverName: drivers.userName,
                            driverLocation: drivers.coordinates,
                            passengerLocation: currentUser.coordinates,
                            pickupLocationName: placemark.name ?? "",
                            dropoffLocationName: dropoffLocation.title,
                            pickupLocationAddress: self.addressFromPlacemark(placemark),
                            pickupLocation: currentUser.coordinates,
                            dropoffLocation: dropoffGeoPoint,
                            tripCost: tripCost,
                            distanceToPassenger: 0,
                            travelTimeToPassenger: 0,
                            state: .requested,
            )
            
            guard let encodedTrip = try? Firestore.Encoder().encode(trip) else { return }
            Firestore.firestore().collection("trips").document().setData(encodedTrip) { _ in
                print("DEBUG: Successfully uploaded trip")
//                self.selectedUberLocation = nil
            }
        }
    }
    
    func cancelTripAsPassenger() {
        updateTripState(state: .passengerCancelled)
    }
}

// MARK: Driver API

extension HomeViewModel {
    
    func addTripObserverForDriver() {
        guard let currentUser = self.currentUser , currentUser.accountType == .driver else { return }
        
        Firestore.firestore().collection("trips")
            .whereField("driverUid", isEqualTo: currentUser.uid)
            .addSnapshotListener { snapshot, _ in
                guard let change = snapshot?.documentChanges.first ,
                        change.type == .added
                        || change.type == .modified else { return }
                
                guard let trip = try? change.document.data(as: Trip.self) else {return}
                self.trip = trip
                
                print("DEBUG : Fetched trip \(trip)")
                
                self.getDestinationRoute(from: trip.driverLocation.toCoordinate(), to: trip.pickupLocation.toCoordinate()) { route in
                    self.routeToPickupLocation = route
                    self.trip?.travelTimeToPassenger = Int(route.expectedTravelTime / 60)
                    self.trip?.distanceToPassenger = route.distance
                }
            }
    }
    
    
    
//    func fetchTrips() {
//        guard let currentUser = currentUser else { return }
//        
//        Firestore.firestore().collection("trips")
//            .whereField("driverUid", isEqualTo: currentUser.uid)
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    print("DEBUG: Failed to fetch trip with error \(error.localizedDescription)")
//                    return
//                }
//                
//                guard let documents = snapshot?.documents , let document = documents.first else { return }
//                guard let trip = try? document.data(as:Trip.self) else {return}
//               
//            
//        }
//    }
    
    func rejectTrip(){
        updateTripState(state: .rejected)
    }
    
    func acceptTrip(){
        updateTripState(state: .accepted)
    }
    
    func cancelTripAsDriver() {
        updateTripState(state: .driverCancelled)
    }
    
}

//MARK: location Search helpers
extension HomeViewModel {
    
    func addressFromPlacemark(_ placemark : CLPlacemark) -> String {
        var result = ""
        if let throughfare =  placemark.thoroughfare{
            result += throughfare
        }
        if let subThoroughfare =  placemark.subThoroughfare{
            result += " \(subThoroughfare)"
        }
        if let subAdministrativeArea = placemark.subAdministrativeArea {
            result += ", \(subAdministrativeArea)"
        }
        
        return result
    }
    
    func getPlacemark(forLocation location : CLLocation, completion : @escaping (CLPlacemark?, Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { MKPlacemarks, error in
            if let error = error {
                print("DEBUG : Error in getting placemark \(error.localizedDescription)")
                return
            }
            
            guard let placemark = MKPlacemarks?.first else { return }
            completion(placemark, nil)
        }
    }
    
    func selectLocation(_ localSearch : MKLocalSearchCompletion, config : locationResultsViewConfig){
        
        locationSearch(forLocationSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("DEBUG : Error in Location Search \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            
            switch config {
            case .ride:
                self.selectedUberLocation = UberLocation(
                    title: localSearch.title,
                    coordinate: coordinate,
                )
            case .saveLocation(let viewModel):
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let savedLocation = SavedLocation(title: localSearch.title, address: localSearch.subtitle, coordinates: GeoPoint(latitude: coordinate.latitude, longitude: coordinate.longitude))
                guard let encodedLocation = try? Firestore.Encoder().encode(savedLocation) else { return }
                
                Firestore.firestore().collection("users").document(uid).updateData([
                    viewModel.dataBaseKey : encodedLocation
                ])
            }
                    
                
        
        }
        
        
        
    }
    
    func locationSearch(forLocationSearchCompletion localSearch : MKLocalSearchCompletion,completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        
        search.start(completionHandler: completion)
        
    }
    
    
    func computeRidePrice(forType type : RideType) -> Double {
        guard let destCoordinate = selectedUberLocation?.coordinate else { return 0.0 }
        guard let userCoordinate = self.userLocation else { return 0.0 }
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        
        let tripDistanceInMeters = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
    }
    
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D , to destination : CLLocationCoordinate2D,
                             completion : @escaping (MKRoute) -> Void) {
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let error = error {
                print("DEBUG : Error in getting route \(error.localizedDescription)")
                return
            }
            
            guard let route = response?.routes.first else { return }
            self.configurePickupAndDropoffTimes(with: route.expectedTravelTime)
            completion(route)
            
        }

    }
    
    func configurePickupAndDropoffTimes(with expectedTravelTime : Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        pickupTime = formatter.string(from: Date())
        dropoffTime = formatter.string(from: Date() + expectedTravelTime)
    }
    
    
}

extension HomeViewModel : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}


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
    private var currentUser : User?
    
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
    
    //MARK: API'S
    
    func fetchUser() {
        service.$user
            .sink { user in
                self.currentUser = user
                guard let user = user else {return }
                if user.accountType == .passenger {
                    self.fetchDrivers()
                }else {
                    self.fetchTrips()
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: Passenger API

extension HomeViewModel {
    
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
            

            let trip = Trip(id: NSUUID().uuidString,
                            passengerUid: currentUser.uid,
                            driverUid: drivers.uid,
                            passengerName: currentUser.userName,
                            driverName: drivers.userName,
                            driverLocation: drivers.coordinates,
                            passengerLocation: currentUser.coordinates,
                            pickupLocationName: placemark.name ?? "",
                            dropoffLocationName: dropoffLocation.title,
                            pickupLocationAddress: "123 Main St",
                            pickupLocation: currentUser.coordinates,
                            dropoffLocation: dropoffGeoPoint,
                            tripCost: 50.0)
            
            guard let encodedTrip = try? Firestore.Encoder().encode(trip) else { return }
            
            Firestore.firestore().collection("trips").document(trip.id).setData(encodedTrip) { error in
                if let error = error {
                    print("DEBUG: Failed to upload trip with error \(error.localizedDescription)")
                    return
                }
                
                print("DEBUG: Successfully uploaded trip")
                self.selectedUberLocation = nil
            }


            
            
        }
        

    }
}

// MARK: Driver API

extension HomeViewModel {
    
    func fetchTrips() {
        guard let currentUser = currentUser else { return }
        
        Firestore.firestore().collection("trips")
            .whereField("driverUid", isEqualTo: currentUser.uid)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch trip with error \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents , let document = documents.first else { return }
                guard let trip = try? document.data(as:Trip.self) else {return}
                self.trip = trip
                
                print("DEBUG : Fetched trip \(trip)")

            
        }
    }
    
}






//MARK: location Search helpers
extension HomeViewModel {
    
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


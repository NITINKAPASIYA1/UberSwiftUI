//
//  LocationSearchViewModel.swift
//  UberSwiftUI
//
//  Created by Nitin on 28/03/25.
//

import Foundation
import MapKit

enum locationResultsViewConfig {
    case ride
    case saveLocation
}

class LocationSearchViewModel : NSObject, ObservableObject {
    
    //MARK: Properties
    
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
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    //MARK: Helpers
    
    func selectLocation(_ localSearch : MKLocalSearchCompletion, config : locationResultsViewConfig){
       switch config {
            case .ride:
               locationSearch(forLocationSearchCompletion: localSearch) { response, error in
                   if let error = error {
                       print("DEBUG : Error in Location Search \(error.localizedDescription)")
                       return
                   }
                   
                   guard let item = response?.mapItems.first else { return }
                   let coordinate = item.placemark.coordinate
                   self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
                   
                   print("DEBUG : Selected Location is : \(coordinate)")
               }
           case .saveLocation:
               print("DEBUG: Save Location")
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

extension LocationSearchViewModel : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}

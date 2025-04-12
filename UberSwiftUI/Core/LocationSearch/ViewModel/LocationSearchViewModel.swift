//
//  LocationSearchViewModel.swift
//  UberSwiftUI
//
//  Created by Nitin on 28/03/25.
//

import Foundation
import MapKit

class LocationSearchViewModel : NSObject, ObservableObject {
    
    //MARK: Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocationCoordinate : CLLocationCoordinate2D?
    
    
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
    
    func selectLocation(_ localSearch : MKLocalSearchCompletion){
        locationSearch(forLocationSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("DEBUG : Error in Location Search \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
            
            print("DEBUG : Selected Location is : \(coordinate)")
        }
    }
    
    func locationSearch(forLocationSearchCompletion localSearch : MKLocalSearchCompletion,completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        
        search.start(completionHandler: completion)
        
    }
    
    
    func computeRidePrice(forType type : RideType) -> Double {
        guard let destCoordinate = selectedLocationCoordinate else { return 0.0 }
        guard let userCoordinate = self.userLocation else { return 0.0 }
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        
        let tripDistanceInMeters = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
    }
    
}

extension LocationSearchViewModel : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}

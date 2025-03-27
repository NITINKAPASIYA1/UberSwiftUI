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
    @Published var selectLocation : String?
    
    
    private let searchCompleter = MKLocalSearchCompleter()
    @Published var queryFragment : String = "" {
        didSet{
            print("DEBUG : Query Frament is : \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    //MARK: Helpers
    
    func selectLocation(_ location : String){
        self.selectLocation = location
        
        print("DEBUG : Selected Location is \(location)")
    }
    
}

extension LocationSearchViewModel : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}

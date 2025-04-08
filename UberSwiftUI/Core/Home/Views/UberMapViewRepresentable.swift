//
//  UberMapViewRepresentable.swift
//  UberSwiftUI
//
//  Created by Nitin on 21/03/25.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isPitchEnabled = true
        // Important: Remove userTrackingMode to prevent auto-centering
        
        // Initial zoom level setup
        if let userLocation = locationManager.userLocation?.coordinate {
            let region = MKCoordinateRegion(
                center: userLocation,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            mapView.setRegion(region, animated: false)
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("DEBUG : Map State is : \(mapState)")
        
        switch mapState {
            case .noInput:
                context.coordinator.clearMapViewAndRecenterOnUserLocation()
                break
            case .searchingForLocation:
                break
            case .locationSelected:
                if let coordinate = locationViewModel.selectLocationCoordinate {
                    context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                    context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
                }
                break
        }
    
            
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(self)
    }
}

extension UberMapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        // MARK: Properties
        
        let parent: UberMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion : MKCoordinateRegion?
        // Flag to track if we've set the initial region
        private var initialRegionSet = false
        
        // MARK: LifeCycle
        
        init(_ parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MARK: MapView Delegate Methods
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            // Only set the region initially when the app starts
            self.userLocationCoordinate = userLocation.coordinate
            if !initialRegionSet {
                if let userCoordinate = parent.locationManager.userLocation?.coordinate {
                    let region = MKCoordinateRegion(
                        center: userCoordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    )
                    self.currentRegion = region
                    mapView.setRegion(region, animated: true)
                    initialRegionSet = true
                }
            }
            
            // Otherwise, do nothing to allow user interaction with the map
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            let over = MKPolylineRenderer(overlay: overlay)
            over.strokeColor = .systemBlue
            over.lineWidth = 5
            over.lineCap = .round
            over.lineJoin = .round
            return over
            
            
        }
        
        // MARK: Helpers
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            
            // Calculate region that includes both user location and destination
            if let userLocation = parent.locationManager.userLocation?.coordinate {
                let regionRect = MKMapRect.init(points: [
                    MKMapPoint(userLocation),
                    MKMapPoint(coordinate)
                ])
                
                // Add some padding around the points
                let padding: CGFloat = 100
                parent.mapView.setVisibleMapRect(regionRect, edgePadding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), animated: true)
            } else {
                // If no user location, just zoom to the annotation
                let region = MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
                parent.mapView.setRegion(region, animated: true)
            }
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
                completion(route)
                
            }

        }
        
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocation = self.userLocationCoordinate else { return }
            getDestinationRoute(from: userLocation, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect,edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
//                self.parent.mapView.setVisibleMapRect(rect, animated: true)
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                
            }
        }
        
        func clearMapViewAndRecenterOnUserLocation() {
            parent.mapView.removeOverlays(parent.mapView.overlays)
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }

        }
    }
}

// Add this extension to MKMapRect for creating a rect from points
extension MKMapRect {
    init(points: [MKMapPoint]) {
        let firstPoint = points.first!
        var rect = MKMapRect(x: firstPoint.x, y: firstPoint.y, width: 0, height: 0)
        
        for point in points {
            rect = rect.union(MKMapRect(x: point.x, y: point.y, width: 0, height: 0))
        }
        
        // Add some buffer
        let bufferFraction: Double = 0.3
        let widthBuffer = rect.size.width * bufferFraction
        let heightBuffer = rect.size.height * bufferFraction
        
        self.init(
            x: rect.minX - widthBuffer/2,
            y: rect.minY - heightBuffer/2,
            width: rect.width + widthBuffer,
            height: rect.height + heightBuffer
        )
    }
}

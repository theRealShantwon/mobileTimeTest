//
//  MapViewScreen.swift
//  MapViewScreen
//
//  Created by macOS Big Sur on 7/28/21.

import SwiftUI
import MapKit

let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
let screen = UIScreen.main.bounds


@available(iOS 15.0, *)
struct MapView: UIViewRepresentable {
    
    @EnvironmentObject var locationSettings: MapViewModel

    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        locationSettings.mapView = MKMapView()
        locationSettings.mapView?.setRegion(locationSettings.region, animated: true)
        locationSettings.mapView?.showsUserLocation = locationSettings.showUsersPosition
        locationSettings.mapView?.userTrackingMode = locationSettings.userTrackingMode
        locationSettings.mapView?.showsBuildings = locationSettings.showsBuildings
        locationSettings.mapView?.showsCompass = locationSettings.showsCompass
        locationSettings.mapView?.showsTraffic = locationSettings.showsTraffic
        locationSettings.mapView?.showsScale = locationSettings.showsScale
        locationSettings.mapView?.delegate = context.coordinator
        let longPress = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.addAnnotation(gesture:)))
        longPress.minimumPressDuration = 0.75
        locationSettings.mapView?.addGestureRecognizer(longPress)
        return locationSettings.mapView!
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    class Coordinator: NSObject,MKMapViewDelegate {
        
        @objc func addAnnotation(gesture: UIGestureRecognizer) {

            if gesture.state == .ended {

                if let mapView = gesture.view as? MKMapView {
                let point = gesture.location(in: mapView)
                let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                    annotation.title = "ANNOTATION"
                    annotation.subtitle = "this is a subtitle"
                mapView.addAnnotation(annotation)
                }
            }
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Capital"

                if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                    annotationView.annotation = annotation
                    return annotationView
                } else {
                    let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                    annotationView.isEnabled = true
                    annotationView.canShowCallout = true
                    annotationView.animatesDrop = true
                    let btn = UIButton(type: .detailDisclosure)
                    annotationView.rightCalloutAccessoryView = btn
                    let btn2 = UIButton(type: .detailDisclosure)
                    annotationView.leftCalloutAccessoryView = btn2
                    return annotationView
                }

        }
        
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
////             Custom Pins....
////
////             Excluding User Blue Circle...
////
////            if annotation.isKind(of: MKUserLocation.self){return nil}
////            else{
////                let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
////
////                pinAnnotation.tintColor = .blue
////                pinAnnotation.animatesDrop = true
////                pinAnnotation.canShowCallout = true
////
////                return pinAnnotation
//            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "customView")
//            annotationView.tintColor = .blue
//            annotationView.animatesDrop = true
//            annotationView.canShowCallout = true
//                //Your custom image icon
//                annotationView.image = UIImage(systemName: "pin.fill")
//                return annotationView
// //           }
//        }
    }
    
}







//
//import SwiftUI
//import MapKit
//
//struct MapItem: Identifiable {
//    let id = UUID()
//    var name: String
//    var coordinate: CLLocationCoordinate2D
//}
//
//var pointsOfInterest = [
//    MapItem(name: "Times Square", coordinate: .init(latitude: 40.75773, longitude: -73.985708)),
//    MapItem(name: "Flatiron Building", coordinate: .init(latitude: 40.741112, longitude: -73.989723)),
//    MapItem(name: "Empire State Building", coordinate: .init(latitude: 40.748817, longitude: -73.985428))
//]
//
//struct MapView: UIViewRepresentable {
//    
//    @EnvironmentObject var locationSettings: LocationSettings
//        
//    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
////        locationSettings.mapView = createMapView(context)
////        return locationSettings.mapView
//        return createMapView(context)
//    }
//    
//    
//    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
//        
//    }
//    
//    
//    
//    func createMapView(_ context: UIViewRepresentableContext<MapView>) -> MKMapView {
//        let lat = locationSettings.location.coordinate.latitude
//        let long = locationSettings.location.coordinate.longitude
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))
//        mapView.showsUserLocation = locationSettings.showUsersPosition
//        mapView.userTrackingMode = locationSettings.userTrackingMode
//        mapView.showsBuildings = locationSettings.showsBuildings
//        mapView.showsCompass = locationSettings.showsCompass
//        mapView.showsTraffic = locationSettings.showsTraffic
//        mapView.showsScale = locationSettings.showsScale
//        mapView.showAnnotations(locationSettings.showAnnotations, animated: true)
//        return mapView
//    }
//
//    func makeCoordinator() -> MapView.Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject, MKMapViewDelegate {
//        
//        var parent: MapView
//        
//        init(_ parent: MapView) {
//            self.parent = parent
//            super.init()
//            
//        }
//
//    }
//}



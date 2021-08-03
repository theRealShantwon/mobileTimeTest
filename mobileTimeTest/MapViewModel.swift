//
//  MapViewModel.swift
//  MapRoutes (iOS)
//
//  Created by Balaji on 03/01/21.
//

import SwiftUI
import MapKit
import CoreLocation



struct Place: Identifiable {
    var id = UUID().uuidString
    var placemark: CLPlacemark
    var color: Color?
}

@available(iOS 15.0, *)
class MapViewModel: NSObject,ObservableObject,CLLocationManagerDelegate{
    
    let defaults = UserDefaults.standard
    
//    @Published var mapView: MKMapView?
//    @Published var locationManager = CLLocationManager()
//    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 33.0202, longitude: -84.9967), latitudinalMeters: 1000, longitudinalMeters: 1000)
//    @Published var location: CLLocation! {
//        didSet {
//            self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
//            if let mapView = self.mapView {
//                mapView.setCenter(location.coordinate, animated: true)
//            }
//        }
//    }
//    @Published var permissionDenied = false
//    @Published var mapTypeInt : Int = 0 {
//        didSet {
//            switch mapTypeInt {
//            case 0:
//                mapType = .standard
//            case 1:
//                mapType = .hybrid
//            default:
//                mapType = .standard
//            }
//            mapView?.mapType = mapType
//        }
//    }
//    @Published var showUsersPosition: Bool = true
//    @Published var showsBuildings: Bool = true
//    @Published var showsCompass: Bool = true
//    @Published var showsTraffic: Bool = true
//    @Published var showsScale: Bool = true
//    @Published var showAnnotations: [MKAnnotation] = []
//    @Published var userTrackingMode: MKUserTrackingMode = .followWithHeading
//    @Published var mapType : MKMapType = .standard
//    @Published var searchTxt = ""
//    @Published var places : [Place] = []
    
    
    @Published var region: MKCoordinateRegion! {
        didSet {
            defaults.set(region.center.latitude, forKey: "savedLatitude")
            defaults.set(region.center.longitude, forKey: "savedLongitude")
        }
    }
    @Published var location: CLLocation! {
        didSet {
            self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            if let mapView = self.mapView {
                mapView.setCenter(location.coordinate, animated: true)
            }
        }
    }
    
    @Published var mapTypeInt : Int = 0 {
        didSet {
            switch mapTypeInt {
            case 0:
                mapType = .standard
            case 1:
                mapType = .hybrid
            default:
                mapType = .standard
            }
            mapView?.mapType = mapType
        }
    }
    @Published var showUsersPosition: Bool = true
    @Published var showsBuildings: Bool! {
        didSet {
            defaults.set(showsBuildings, forKey: "showsBuildings")
        }
    }
    @Published var showsCompass: Bool! {
        didSet {
            defaults.set(showsCompass, forKey: "showsCompass")
        }
    }
    @Published var showsTraffic: Bool! {
        didSet {
            defaults.set(showsTraffic, forKey: "showsTraffic")
        }
    }
    @Published var showsScale: Bool! {
        didSet {
            defaults.set(showsScale, forKey: "showsScale")
        }
    }
    
    @Published var mapView: MKMapView?
    @Published var locationManager = CLLocationManager()
    @Published var permissionDenied = false
    @Published var showAnnotations: [MKAnnotation] = []
    @Published var userTrackingMode: MKUserTrackingMode = .followWithHeading
    @Published var mapType : MKMapType = .standard
    @Published var searchTxt = ""
    @Published var places : [Place] = []

    override init() {
        super.init()
        setUIControlAttributes()
        setupManager()
        setSavedValues()
        
    }
    func setSavedValues() {
        if defaults.double(forKey: "savedLatitude") == 0.0 {
            defaults.set(33.0202, forKey: "savedLatitude")
            defaults.set(-84.9967, forKey: "savedLongitude")
        }
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: defaults.double(forKey: "savedLatitude"), longitude: defaults.double(forKey: "savedLongitude")), latitudinalMeters: 1000, longitudinalMeters: 1000)
        showsBuildings = defaults.bool(forKey: "showsBuildings")
        showsCompass = defaults.bool(forKey: "showsCompass")
        showsTraffic = defaults.bool(forKey: "showsTraffic")
        showsScale = defaults.bool(forKey: "showsScale")
    }
    
    func setUIControlAttributes() {
        UITableView.appearance().backgroundColor = UIColor.clear
        UISegmentedControl.appearance().backgroundColor = UIColor(hue: 0.664, saturation: 0.019, brightness: 0.967, alpha: 0.5)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }

    // Focus Location...
    func focusLocation(){
        let coordinateRegion = MKCoordinateRegion(center: region.center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView?.setRegion(coordinateRegion, animated: true)
        mapView?.setCenter(region.center, animated: true)
    }
    
    // Search Places...
    func searchQuery(){
        
        places.removeAll()
        let request = MKLocalSearch.Request()
        request.region = region
        request.naturalLanguageQuery = searchTxt
        // Fetch...
        MKLocalSearch(request: request).start { (response, _) in
            
            guard let result = response else{return}
            self.places = result.mapItems.compactMap({ (item) -> Place? in
                return Place(placemark: item.placemark)
            })
            
        }
    }
    
    // Pick Search Result...
    func selectPlace(place: Place){
        
        // Showing Pin On Map....
        
        searchTxt = ""
        
        guard let coordinate = place.placemark.location?.coordinate else{return}
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.placemark.name ?? "No Name"
        
        // Removing All Old Ones...
        mapView?.removeAnnotations(mapView!.annotations)
        
        mapView?.addAnnotation(pointAnnotation)
        
        // Moving Map To That Location...
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
        
        mapView?.setRegion(coordinateRegion, animated: true)
        mapView?.setCenter(coordinate, animated: true)
    }

    func requestAuthorization() {
        if locationManager.authorizationStatus != .authorizedWhenInUse  {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.requestLocation()
        }
    }
    
    func setupManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.showsBackgroundLocationIndicator = false
        locationManager.activityType = .automotiveNavigation
        if locationManager.authorizationStatus == .authorizedWhenInUse  {
            locationManager.requestLocation()
        }
    }
        
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Checking Permissions...
        switch manager.authorizationStatus {
        case .denied:
            // Alert...
            permissionDenied.toggle()
        case .notDetermined:
            // Requesting....
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            // If Permissin Given...
            manager.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.requestLocation()
        // Error....
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            self.location = location
            print(location)
        }
        
    }
}

//  MapScreen.swift
//  MapScreen
//
//  Created by macOS Big Sur on 7/28/21.
//
import SwiftUI
import MapKit
import CoreLocation
import FloatingSegmentedControl

@available(iOS 15.0, *)
struct MapScreen: View {

    @EnvironmentObject var locationSettings: MapViewModel
    let items = ["Map", "Satellite"]
    @State private var showMenu = false
        
    var body: some View {
        
        ZStack{
            MapView()
                .ignoresSafeArea(.all, edges: .all)
                .onTapGesture() {
                        print("Double tapped!")
                    }
                .onLongPressGesture {
                    print("LONG PRESSED")
                }
                VStack {
                    MapSearchView()
                        .padding(.horizontal, 15)
                    MapTopButtonsView()

                    if locationSettings.places.isEmpty && locationSettings.searchTxt == "" {
                        MapMenuButton(showMenu: $showMenu)
                            .offset(x: 75)
                    }
                    if !locationSettings.places.isEmpty && locationSettings.searchTxt != "" {
                        MapSearchFormView()
                    }
                    Spacer()
                }
                MapViewMenu(showMenu: $showMenu)
        }
        .onAppear(perform: {
            if locationSettings.locationManager.authorizationStatus != .authorizedWhenInUse  {
                locationSettings.requestAuthorization()
            }
        })
        .alert(isPresented: $locationSettings.permissionDenied, content: {
            Alert(title: Text("Permission Denied"), message: Text("Please Enable Permission In App Settings"), dismissButton: .default(Text("Goto Settings"), action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
        .onChange(of: locationSettings.searchTxt, perform: { value in
            let delay = 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if value == locationSettings.searchTxt{
                    // Search...
                    self.locationSettings.searchQuery()
                }
            }
        })
    }
}


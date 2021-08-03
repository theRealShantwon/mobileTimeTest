//
//  MapViewToggles.swift
//  MapViewToggles
//
//  Created by Shannon Anthony on 8/2/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct MapViewToggles: View {
    
    @EnvironmentObject var locationSettings: MapViewModel
    @Binding var showMenu: Bool

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Color(hue: 0.664, saturation: 0.019, brightness: 0.967, opacity: 1.0)
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onEnded({ value in
                        if value.translation.width > 0.5 {
                                showMenu.toggle()
                         }
                     }))
                VStack {
                    Text("Map Menu")
                        .foregroundColor(Color(hue: 0.664, saturation: 0.019, brightness: 0.333, opacity: 1.0))
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .offset(x: -40, y: 0)
                        .padding(.bottom, 30)
                    
                    MapViewToggle(locationBool: $locationSettings.showUsersPosition, showMenu: $showMenu, sectionTitle: "Location", toggleTitle: "Show Location", imageTitle: "location.circle.fill", addLabel: true)
                    MapViewToggle(locationBool: $locationSettings.showsTraffic, showMenu: $showMenu, sectionTitle: "Tools", toggleTitle: "Show Traffic", imageTitle: "hammer.fill", addLabel: true)
                        .toggleStyle(MapCheckboxStyle())
                        .padding(.top, 30)
                    MapViewToggle(locationBool: $locationSettings.showsBuildings, showMenu: $showMenu, sectionTitle: "", toggleTitle: "Show Buildings", addLabel: false)
                        .toggleStyle(MapCheckboxStyle())
                        .padding(.top, -5)
                    MapViewToggle(locationBool: $locationSettings.showsCompass, showMenu: $showMenu, sectionTitle: "", toggleTitle: "Show Compass", addLabel: false)
                        .toggleStyle(MapCheckboxStyle())
                        .padding(.top, -5)
                    MapViewToggle(locationBool: $locationSettings.showsScale, showMenu: $showMenu, sectionTitle: "", toggleTitle: "Show Scale", addLabel: false)
                        .toggleStyle(MapCheckboxStyle())
                        .padding(.top, -5)
                    Section {
                        HStack {
                            Button {
                                
                            } label: {
                                Text("Add Map Pin")
                                    .font(.system(size: 16, weight: .bold, design: .default))
                                Spacer()
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.green)
                                    

                            }
                        }
                        .padding(.horizontal, 10)
                    }
                    .background(Color.white)
                    .padding(.top, 30)
                    Spacer()
                }
                .foregroundColor(Color(hue: 0.664, saturation: 0.2, brightness: 0.4, opacity: 1.0))
                .padding(.top, 15)

            }
        }
    }
}

struct MapViewToggle: View {
    
    @Binding var locationBool: Bool
    @Binding var showMenu: Bool
    var sectionTitle: String
    var toggleTitle: String
    var imageTitle: String?
    var addLabel: Bool
    
    var body: some View {
        if addLabel {
            VStack {
                Label(sectionTitle, systemImage: imageTitle ?? "exclamationmark.triangle.fill")
                    .foregroundColor(Color(hue: 0.664, saturation: 0.019, brightness: 0.333, opacity: 1.0))
                    .font(.headline)
                Section() {
                    Toggle(toggleTitle, isOn: $locationBool.animation())
                        .padding(.horizontal, 10)
                }
                .font(.subheadline)
                .background(Color.white)
            }
        } else {
                Section() {
                    Toggle(toggleTitle, isOn: $locationBool.animation())
                        .padding(.horizontal, 10)
                }
                .font(.subheadline)
                .background(Color.white)
        }
    }
}

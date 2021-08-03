//
//  MapSearchFormView.swift
//  MapSearchFormView
//
//  Created by Shannon Anthony on 8/2/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct MapSearchFormView: View {
    
    @EnvironmentObject var locationSettings: MapViewModel
        
    var body: some View {
        Form {
            ForEach(locationSettings.places) { place in
                Button {
                    locationSettings.selectPlace(place: place)
                } label: {
                    
                    VStack(alignment: .leading) {
                        Text(place.placemark.name ?? "")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.blue)

                        Text("\(place.placemark.subThoroughfare ?? "") \(place.placemark.thoroughfare ?? "") \(place.placemark.locality ?? ""), \(place.placemark.administrativeArea ?? "")")
                            .font(.system(size: 13))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 100, alignment: .center)
        .cornerRadius(20)
    }
}

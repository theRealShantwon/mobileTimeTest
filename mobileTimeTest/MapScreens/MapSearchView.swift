//
//  MapSearchView.swift
//  MapSearchView
//
//  Created by Shannon Anthony on 8/2/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct MapSearchView: View {
    
    @EnvironmentObject var locationSettings: MapViewModel
        
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search", text: $locationSettings.searchTxt)
                .colorScheme(.light)
        }
        .padding(.vertical, 7)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .black, radius: 0.75, x: 0, y: 0)
    }
}

//
//  MapTopButtonsView.swift
//  MapTopButtonsView
//
//  Created by Shannon Anthony on 8/2/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct MapTopButtonsView: View {
    
    @EnvironmentObject var locationSettings: MapViewModel
    let items = ["Map", "Satellite"]
        
    var body: some View {
        HStack(spacing: 20) {
            Button {
                
            } label: {
                Image(systemName: "arrowshape.turn.up.left.fill")
                    .aspectRatio(contentMode: .fit)
                    .font(.title2)
                    .padding(5)
            }
            Picker("Change Shape", selection: $locationSettings.mapTypeInt) {
                ForEach(items, id: \.self) {
                    Text($0)
                        .tag(items.firstIndex(of: $0)!)
                }
            }
            .shadow(color: .black, radius: 1, x: 0, y: 0)
            .pickerStyle(SegmentedPickerStyle())
            Button(action: locationSettings.focusLocation, label: {
                Image(systemName: "location.fill")
                    .font(.title2)
                    .padding(5)
                    .background(Color.primary)
                    .clipShape(Circle())
            })
        }
        .padding(.horizontal, 15)
        .padding(.top, 3)
        .padding(.bottom, 10)
    }
}

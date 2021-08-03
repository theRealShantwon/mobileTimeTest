//
//  MapViewMenu.swift
//  MapViewMenu
//
//  Created by Shannon Anthony on 8/2/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct MapViewMenu: View {
    
    @EnvironmentObject var locationSettings: MapViewModel
    @Binding var showMenu: Bool
    
    var body: some View {
        ZStack {
            Color("button")
                
            VStack(alignment: .leading) {
                MapViewToggles(showMenu: $showMenu)
            }
        .cornerRadius(30)
            .padding(.top, 15)
            .padding(.leading, 15)
            .padding(.trailing, 30)
            .padding(.bottom, 15)

        }
        .frame(minWidth: 0, maxWidth: 315)
        .cornerRadius(30)
        .shadow(radius: 20)
        .rotation3DEffect(Angle(degrees: showMenu ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
        .animation(showMenu ? .default : .spring())
        .offset(x: showMenu ? UIScreen.main.bounds.width - 315 : UIScreen.main.bounds.width)
        .padding(.trailing, 60)
        .padding(.top, statusBarHeight)
        .padding(.bottom, 30)
        .contentShape(Rectangle())
    }
}
struct MapCheckboxStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.rectangle.fill" : "rectangle")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(configuration.isOn ? Color(hue: 0.444, saturation: 0.8, brightness: 0.6, opacity: 1.0) : Color(hue: 1, saturation: 0.9, brightness: 0.4, opacity: 1.0))
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

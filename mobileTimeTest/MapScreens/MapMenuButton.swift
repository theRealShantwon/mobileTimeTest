//
//  MapMenuButton.swift
//  MapMenuButton
//
//  Created by Shannon Anthony on 8/2/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct MapMenuButton: View {
   @Binding var showMenu: Bool

   var body: some View {
       VStack {
           Spacer()
           HStack {
               Spacer()
               ZStack(alignment: .topLeading) {
                 Button(action: { self.showMenu.toggle() }) {
                    HStack {
                       Spacer()

                       Image(systemName: "chevron.compact.left")
                            .foregroundColor(.orange)
                          .imageScale(.large)
                          .offset(x: -60)
                    }
                    .padding(.trailing, 18)
                    .frame(width: 90, height: 60)
                    .background(Color("button"))
                    .cornerRadius(30)
                 }
                 Spacer()
              }
              .shadow(color: Color(UIColor.black).opacity(0.6), radius: 5, x: 0, y: 2)
           }
           Spacer()
       }
   }
}

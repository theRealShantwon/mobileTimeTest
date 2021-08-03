//
//  mobileTimeTestApp.swift
//  mobileTimeTest
//
//  Created by Shannon Anthony on 8/2/21.
//

import SwiftUI

@available(iOS 15.0, *)
@main
struct mobileTimeTestApp: App {
    @StateObject private var locationSettings = MapViewModel()

    var body: some Scene {
        WindowGroup {
            MapScreen()
                .environmentObject(locationSettings)

        }
    }
}

//
//  WeatherApp.swift
//  Weather
//
//  Created by Dat on 02/03/2025.
//

import SwiftUI

@main
struct WeatherApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var rootViewModel = RootViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(rootViewModel)
        }
    }
}

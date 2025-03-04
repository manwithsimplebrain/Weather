//
//  MainView.swift
//  Weather
//
//  Created by Dat on 02/03/2025.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        TabView {
            WeatherView()
                .tabItem {
                    Label("weather".localized, systemImage: "thermometer")
                }
            
            SettingView()
                .tabItem {
                    Label("settings".localized, systemImage: "gear")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

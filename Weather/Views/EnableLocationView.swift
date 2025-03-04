//
//  EnableLocationView.swift
//  Weather
//
//  Created by Dat Doan on 3/3/25.
//

import SwiftUI

struct EnableLocationView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(edges: .all)
            VStack(spacing: 20) {
                Image(systemName: "mappin.and.ellipse")
                    .resizable()
                    .imageScale(.large)
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .foregroundStyle(.secondary)
                
                Text("Enable Location Services")
                    .font(.headline)
                Text("To get weather forecast for your current location, please enable location services in your device settings.")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                
                Button(action: openAppSettings) {
                    Text("Turn on Location")
                        .font(.headline)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                }
            }
            .padding()
        }
    }
    
    private func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    EnableLocationView()
}

//
//  SettingView.swift
//  Weather
//
//  Created by Dat on 02/03/2025.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("cached") private var isCached = false
    @AppStorage("autoUpdate") private var isAutoUpdate = false
    @State private var updateTime = Date()
    @AppStorage("unit") private var unit = "°C"
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Cached", isOn: $isCached)
                    
                    Toggle("Auto update", isOn: $isAutoUpdate)
                    DatePicker("Choose update time", selection: $updateTime, displayedComponents: .hourAndMinute)
                    Button("Clear cache", role: .destructive, action: { })
                } header: {
                    Text("Operation")
                        .font(.headline)
                }
                
                Section {
                    Picker("Unit", selection: $unit) {
                        ForEach(["°C", "°F"], id: \.self) { unit in
                            Text(unit).tag(unit)
                        }
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("Display")
                        .font(.headline)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

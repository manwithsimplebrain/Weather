//
//  WeatherView.swift
//  Weather
//
//  Created by Dat on 02/03/2025.
//

import SwiftUI
import CoreLocationUI

struct WeatherView: View {
    var body: some View {
        ZStack {
            background
            mainContent
        }
        .task {
            do {
                let stub = StubRepository()
                let weather = try await stub.fetchWeather(lat: 10, long: 10)
                print(weather)
            } catch {
                print("Load weather faild: \(error)")
            }
        }
    }
    
    var background: some View {
        Color.white
            .ignoresSafeArea()
    }
    
    var mainContent: some View {
        VStack {
            topContent
            Spacer()
            bottomContent
        }
    }
    
    var topContent: some View {
        VStack(spacing: 45) {
            locationSection
            tempertureSection
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
    
    var bottomContent: some View {
        VStack(spacing: 20) {
            Text("Today's Weather")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                MesurementView(title: "Min Temp", subtitle: "21°", image: Image(systemName: "thermometer"))
                Spacer()
                MesurementView(title: "Max Temp", subtitle: "31°", image: Image(systemName: "thermometer"))
            }
            HStack {
                MesurementView(title: "Wind Speed", subtitle: "2m/s", image: Image(systemName: "wind.snow"))
                Spacer()
                MesurementView(title: "Humidity", subtitle: "56%", image: Image(systemName: "humidity"))
            }
            HStack {
                MesurementView(title: "Pressure", subtitle: "1000hpa", image: Image(systemName: "aqi.medium"))
                Spacer()
            }
        }
        .foregroundColor(.secondary)
        .padding()
        .background(.ultraThinMaterial)
        .backgroundStyle(.blue)
        .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))
    }
    
    var locationSection: some View {
        VStack(alignment: .leading) {
            Text("London")
                .font(.system(size: 50))
                .fontWeight(.heavy)
                .bold()
            Text("Last update at: \(Date().formatted())")
                .font(.headline)
                .fontWeight(.medium)
        }
        .foregroundColor(.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var tempertureSection: some View {
        HStack {
            VStack {
                Image(systemName: "cloud.moon")
                    .imageScale(.large)
                    .font(.system(size: 50))
                Text("Clouds")
                    .fontWeight(.medium)
                    .font(.system(size: 25))
            }
            
            Spacer()
            
            Text("21°")
                .font(.system(size: 80))
        }
        .foregroundColor(.secondary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


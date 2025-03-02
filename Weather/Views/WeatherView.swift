//
//  WeatherView.swift
//  Weather
//
//  Created by Dat on 02/03/2025.
//

import SwiftUI
import CoreLocationUI

struct WeatherView: View {
    @State private var weather: Weather?
    
    var body: some View {
        ZStack {
            if weather != nil {
                mainContent
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .background(background) // set backgound here to content fit into screen
        .task {
            do {
                let repository = WeatherRepository()
                let weather = try await repository.fetchWeather(lat: 44.34, long: 10.99)
                self.weather = weather
            } catch {
                print("Load weather faild: \(error)")
            }
        }
    }
    
    var background: some View {
        Image("blue_cloud_sky")
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            .ignoresSafeArea()
            .blur(radius: 10)
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
                MesurementView(
                    title: "Min Temp",
                    subtitle: weather!.minTempString,
                    image: Image(systemName: "thermometer")
                )
                Spacer()
                MesurementView(
                    title: "Max Temp",
                    subtitle: weather!.maxTempString,
                    image: Image(systemName: "thermometer")
                )
            }
            HStack {
                MesurementView(
                    title: "Wind Speed",
                    subtitle: weather!.windString,
                    image: Image(systemName: "wind.snow")
                )
                Spacer()
                MesurementView(
                    title: "Humidity",
                    subtitle: weather!.humidityString,
                    image: Image(systemName: "humidity")
                )
            }
            HStack {
                MesurementView(
                    title: "Pressure",
                    subtitle: weather!.pressureString,
                    image: Image(systemName: "aqi.medium")
                )
                Spacer()
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).ignoresSafeArea())
        .backgroundStyle(.black)
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
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var tempertureSection: some View {
        HStack {
            VStack {
                Image(systemName: weather!.symbol)
                    .imageScale(.large)
                    .font(.system(size: 50))
                Text(weather!.status)
                    .fontWeight(.medium)
                    .font(.system(size: 25))
            }
            
            Spacer()
            
            Text("\(Int(weather!.temp.rounded()))°")
                .font(.system(size: 80))
                
        }
        .foregroundColor(.white)
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


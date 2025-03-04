//
//  WeatherView.swift
//  Weather
//
//  Created by Dat on 02/03/2025.
//

import SwiftUI
import CoreLocationUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.weather != nil {
                mainContent
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            if viewModel.showGuideView {
                EnableLocationView()
                    .background(.white)
            }
        }
        .background(background) // set backgound here to content fit into screen
        .onAppear {
            viewModel.requestLocationPermission()
        }
    }
    
    var background: some View {
        Image("star_sky")
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
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
    
    @ViewBuilder
    var bottomContent: some View {
        let weather = viewModel.weather
        
        VStack(spacing: 20) {
            Text(viewModel.todayWeather)
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                MesurementView(
                    title: viewModel.minTemperature,
                    subtitle: weather!.minTempString,
                    image: Image(systemName: "thermometer")
                )
                Spacer()
                MesurementView(
                    title: viewModel.maxTemperature,
                    subtitle: weather!.maxTempString,
                    image: Image(systemName: "thermometer")
                )
            }
            HStack {
                MesurementView(
                    title: viewModel.windSpeed,
                    subtitle: weather!.windString,
                    image: Image(systemName: "wind.snow")
                )
                Spacer()
                MesurementView(
                    title: viewModel.humidity,
                    subtitle: weather!.humidityString,
                    image: Image(systemName: "humidity")
                )
            }
            HStack {
                MesurementView(
                    title: viewModel.pressure,
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
            Text(viewModel.address?.city ?? "")
                .font(.system(size: 50))
                .fontWeight(.heavy)
                .bold()
            Text("\(viewModel.lastUpdateAt) \(Date().formatted())")
                .font(.headline)
                .fontWeight(.medium)
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    var tempertureSection: some View {
        let weather = viewModel.weather
        
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


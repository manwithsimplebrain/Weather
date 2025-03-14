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
    @State private var showSearchingLocation = false
    
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
    
    @ViewBuilder
    var background: some View {
        if let bgImage = viewModel.backgroundImage {
            Image(uiImage: bgImage)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
        }
    }
    
    var mainContent: some View {
        VStack {
            topContent
            Spacer()
            bottomContent
        }
        .fullScreenCover(isPresented: $showSearchingLocation) {
            SearchLocationView(selectedLocation: $viewModel.location)
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
                    title: viewModel.temperature,
                    subtitle: weather!.minMaxTempString,
                    image: Image(systemName: "thermometer")
                )
                Spacer()
                MesurementView(
                    title: viewModel.windSpeed,
                    subtitle: weather!.windString,
                    image: Image(systemName: "wind.snow")
                )
            }
            HStack {
                MesurementView(
                    title: viewModel.humidity,
                    subtitle: weather!.humidityString,
                    image: Image(systemName: "humidity")
                )
                Spacer()
                MesurementView(
                    title: viewModel.pressure,
                    subtitle: weather!.pressureString,
                    image: Image(systemName: "aqi.medium")
                )
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        )
        .backgroundStyle(.black)
    }
    
    var locationSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.place)
                    .font(.system(size: 50))
                    .fontWeight(.heavy)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                Spacer()
                Button {
                    showSearchingLocation.toggle()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                        .fontWeight(.bold)
                }
                .padding(10)
                .foregroundStyle(.white)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }
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
            .environmentObject(WeatherViewModel())
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


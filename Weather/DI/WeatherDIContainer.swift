//
//  WeatherDIContainer.swift
//  Weather
//
//  Created by Dat Doan on 3/3/25.
//

import Foundation
import Factory

extension Container {
    private var networkService: Factory<NetworkServiceable> {
        Factory(self) { NetworkService()}
    }
    
    var locationService: Factory<LocationServiceable> {
        Factory(self) { LocationService() }
    }
    
    var weatherRepository: Factory<WeatherRepository> {
        Factory(self) {
            OpenWeatherMapRepository(service: self.networkService())
        }
    }
    
    var geoRepository: Factory<GeoRepository> {
        Factory(self) {
            OpenStreetMapRepository(service: self.networkService())
        }
    }
}

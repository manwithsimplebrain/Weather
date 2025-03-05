//
//  WeatherDIContainer.swift
//  Weather
//
//  Created by Dat Doan on 3/3/25.
//

import Foundation
import Factory
import Networking

extension Container {
//    private var networkService: Factory<NetworkServiceable> {
//        Factory(self) { NetworkService()}
//    }
    
    var locationService: Factory<LocationServiceable> {
        Factory(self) { LocationService() }
    }
    
    var weatherRepository: Factory<WeatherRepository> {
        Factory(self) {
            OpenWeatherMapRepository()
        }
    }
    
    var geoRepository: Factory<GeoRepository> {
        Factory(self) {
            OpenStreetMapRepository()
        }
    }
}

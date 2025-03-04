//
//  WeatherRepository.swift
//  Weather
//
//  Created by Dat on 02/03/2025.
//

import Foundation

struct OpenWeatherMapEndpoint: Endpoint {
    var url: URL?
    var queryItems: [URLQueryItem]?
    
    init() {
        self.url = URL(string: "https://api.openweathermap.org/data/2.5/weather")
    }
}

final class OpenWeatherMapRepository: WeatherRepository {
    private let service: NetworkServiceable
    
    init(service: NetworkServiceable = NetworkService()) {
        self.service = service
    }
    
    func fetchWeather(lat: Double, long: Double) async throws -> Weather {
        var endpoint = OpenWeatherMapEndpoint()
        endpoint.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(long)),
            URLQueryItem(name: "appid", value: "7dd3af04282f3d5c97c839e4b63cec98"),
            URLQueryItem(name: "units", value: "metric")
        ]
        return try await service.request(endpoint)
    }
}

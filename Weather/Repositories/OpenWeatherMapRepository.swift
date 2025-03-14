//
//  WeatherRepository.swift
//  Weather
//
//  Created by Dat on 02/03/2025.
//

import Foundation
import Networking
import Factory

final class OpenWeatherMapRepository: WeatherRepository {
    @Injected(\.networkService) private var service: NetworkService
    
    func fetchWeather(lat: Double, long: Double) async throws -> Weather {
        let request = Request(
            url: URL(string: "https://api.openweathermap.org/data/2.5/weather")!,
            queryItems: [
                "lat" : String(lat),
                "lon" : String(long),
                "appid" : "7dd3af04282f3d5c97c839e4b63cec98",
                "units" : "metric"
            ],
//            cachePolicy: .returnCacheDataElseLoad(ttl: 60) // caching 5 minutes
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        return try await service.requestObject(request: request)
    }
}

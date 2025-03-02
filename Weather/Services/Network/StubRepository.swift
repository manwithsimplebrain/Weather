//
//  StubRepository.swift
//  Weather
//
//  Created by Dat on 02/03/2025.
//

import Foundation

class StubRepository: WeatherClient {
    func fetchWeather(lat: Double, long: Double) async throws -> Weather {
        guard let weatherURL = Bundle.main.url(forResource: "weather", withExtension: "json") else {
            throw NSError()
        }
        let data = try Data(contentsOf: weatherURL)
        let response = try JSONDecoder().decode(Weather.self, from: data)
        return response
    }
}

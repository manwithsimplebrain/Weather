//
//  WeatherClient.swift
//  Weather
//
//  Created by Dat on 02/03/2025.
//

import Foundation

protocol WeatherClient {
    func fetchWeather(lat: Double, long: Double) async throws -> Weather
}

//
//  Weather.swift
//  Weather
//
//  Created by Dat on 02/03/2025.
//

import Foundation

struct Weather: Decodable {
    let status: String
    let icon: String
    let temp: Double
    let min: Double
    let max: Double
    let wind: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingsKey: String, CodingKey {
        case weather
        case main
        case wind
    }
    
    enum WeatherKeys: String, CodingKey {
        case main
        case icon
    }
    
    enum MainKeys: String, CodingKey {
        case temp
        case icon
        case min = "temp_min"
        case max = "temp_max"
        case pressure
        case humidity
    }
    
    enum WindKeys: CodingKey {
        case speed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingsKey.self)
        
        // ✅ Giải mã mảng "weather", lấy phần tử đầu tiên
        var weatherArray = try container.nestedUnkeyedContainer(forKey: .weather)
        let weatherContainer = try weatherArray.nestedContainer(keyedBy: WeatherKeys.self)
        status = try weatherContainer.decode(String.self, forKey: .main)
        icon = try weatherContainer.decode(String.self, forKey: .icon)
        
        // ✅ Giải mã phần "main"
        let mainContainer = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        temp = try mainContainer.decode(Double.self, forKey: .temp)
        min = try mainContainer.decode(Double.self, forKey: .min)
        max = try mainContainer.decode(Double.self, forKey: .max)
        pressure = try mainContainer.decode(Int.self, forKey: .pressure)
        humidity = try mainContainer.decode(Int.self, forKey: .humidity)
        
        // ✅ Giải mã "wind"
        let windContainer = try container.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        wind = try windContainer.decode(Double.self, forKey: .speed)
    }
    
}

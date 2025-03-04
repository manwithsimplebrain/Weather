//
//  Address.swift
//  Weather
//
//  Created by Dat Doan on 3/3/25.
//

import Foundation

struct Address: Decodable {
    let office: String?
    let road: String?
    let neighbourhood: String?
    let quarter: String?
    let suburb: String?
    let city: String?
    let country: String?

    enum AddressKeys: String, CodingKey {
        case office, road, neighbourhood, quarter, suburb, city
        case country
    }
    
    enum CodingKeys: String, CodingKey {
        case address
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let addressContainer = try container.nestedContainer(keyedBy: AddressKeys.self, forKey: .address)
        self.office = try addressContainer.decodeIfPresent(String.self, forKey: .office)
        self.road = try addressContainer.decodeIfPresent(String.self, forKey: .road)
        self.neighbourhood = try addressContainer.decodeIfPresent(String.self, forKey: .neighbourhood)
        self.quarter = try addressContainer.decodeIfPresent(String.self, forKey: .quarter)
        self.suburb = try addressContainer.decodeIfPresent(String.self, forKey: .suburb)
        self.city = try addressContainer.decodeIfPresent(String.self, forKey: .city)
        self.country = try addressContainer.decodeIfPresent(String.self, forKey: .country)
    }
}

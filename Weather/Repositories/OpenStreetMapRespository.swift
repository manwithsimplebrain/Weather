//
//  OpenStreetMapRespository.swift
//  Weather
//
//  Created by Dat Doan on 3/3/25.
//

import Foundation

struct OpenStreetMapEndpoint: Endpoint {
    var url: URL?
    var queryItems: [URLQueryItem]?
    
    init() {
        self.url = URL(string: "https://nominatim.openstreetmap.org/reverse")
    }
}

final class OpenStreetMapRepository: GeoRepository {
    private let service: NetworkServiceable
    
    init(service: NetworkServiceable = NetworkService()) {
        self.service = service
    }
    
    func convert(lat: Double, long: Double) async throws -> Address {
        var endpoint = OpenStreetMapEndpoint()
        endpoint.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(long)),
            URLQueryItem(name: "format", value: "json")
        ]
        return try await service.request(endpoint)
    }
}

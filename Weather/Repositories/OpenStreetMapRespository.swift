//
//  OpenStreetMapRespository.swift
//  Weather
//
//  Created by Dat Doan on 3/3/25.
//

import Foundation
import Networking

final class OpenStreetMapRepository: GeoRepository {
    private let service: NetworkService
    
    init() {
        self.service = NetworkService()
    }
    
    func convert(lat: Double, long: Double) async throws -> Address {
        let request = Request(
            url: URL(string: "https://nominatim.openstreetmap.org/reverse")!,
            queryItems: [
                "lat" : String(lat),
                "lon" : String(long),
                "format" : "json"
            ]
        )
        return try await service.requestObject(request: request)
    }
}

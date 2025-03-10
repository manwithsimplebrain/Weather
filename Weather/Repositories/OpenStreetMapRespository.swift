//
//  OpenStreetMapRespository.swift
//  Weather
//
//  Created by Dat Doan on 3/3/25.
//

import Foundation
import Networking
import Factory

final class OpenStreetMapRepository: GeoRepository {
    @Injected(\.networkService) private var service: NetworkService
    
    func convert(lat: Double, long: Double) async throws -> Address {
        let request = Request(
            url: URL(string: "https://nominatim.openstreetmap.org/reverse")!,
            queryItems: [
                "lat" : String(lat),
                "lon" : String(long),
                "format" : "json"
            ],
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        return try await service.requestObject(request: request)
    }
}

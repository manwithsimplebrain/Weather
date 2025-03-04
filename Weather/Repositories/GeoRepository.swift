//
//  GeoRepository.swift
//  Weather
//
//  Created by Dat Doan on 3/3/25.
//

import Foundation

protocol GeoRepository {
    func convert(lat: Double, long: Double) async throws -> Address
}

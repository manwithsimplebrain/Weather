//
//  NetworkServiceable.swift
//  Weather
//
//  Created by Dat Doan on 3/3/25.
//

import Foundation

protocol NetworkServiceable {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

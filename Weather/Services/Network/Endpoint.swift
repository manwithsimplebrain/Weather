//
//  Endpoint.swift
//  Weather
//
//  Created by Dat on 02/03/2025.
//

import Foundation

protocol Endpoint {
    var url: URL? { get }
    var method: HTTPMethod { get }
    var body: [String: Any]? { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    var method: HTTPMethod { return .GET }
    
    var body: [String: Any]? { return nil }
    
    var headers: [String: String] { return ["Content-Type": "application/json"] }
    
    var queryItems: [URLQueryItem]? { return nil }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

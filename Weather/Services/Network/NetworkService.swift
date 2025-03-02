//
//  NetworkService.swift
//  Weather
//
//  Created by Dat on 02/03/2025.
//

import Foundation


class NetworkService {
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let items = endpoint.queryItems {
            var queryItems = components?.queryItems ?? []
            queryItems += items
        }
        
        var request = URLRequest(url: components?.url ?? url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}

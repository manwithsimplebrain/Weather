//
//  OauthAuthManager.swift
//  Weather
//
//  Created by Dat Doan on 6/3/25.
//

import Foundation
import Networking

actor OauthAuthManager {
    private let baseURL: URL
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    private let tokenStorage: TokenStorage
    private var refreshTask: Task<Void, Error>?
    
    init(baseURL: String,
         urlSession: URLSession = .shared,
         jsonDecoder: JSONDecoder = JSONDecoder(),
         tokenStorage: TokenStorage) {
        self.baseURL = URL(string: baseURL)!
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
        self.tokenStorage = tokenStorage
    }
}

extension OauthAuthManager: AuthManager {
    func authenticate(for request: URLRequest) async throws -> URLRequest {
        if await tokenStorage.isTokenExpired {
            try await refreshToken()
        }
        var request = request
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Authorization"] = "Bearer \(await tokenStorage.accessToken ?? "")"
        request.allHTTPHeaderFields = headers
        return request
    }
    
    func refreshToken() async throws {
        if let refreshTask {
            return try await refreshTask.value
        }
        refreshTask = Task {
            defer { refreshTask = nil }
            let token = await tokenStorage.refershToken ?? ""
            let newTokens = try await refreshToken(token)
            await tokenStorage.update(tokens: newTokens)
        }
        return try await refreshTask!.value
    }
}

extension OauthAuthManager: Authenticator {
    func refreshToken(_ refreshToken: String) async throws -> AuthTokens {
        let request = try makeRefreshTokenRequest(refreshToken: refreshToken)
        return try await execute(request)
    }

    func login(username: String, password: String) async throws -> AuthTokens {
        let request = try makeLoginRequest(username: username, password: password)
        let tokens = try await execute(request)
        await tokenStorage.update(tokens: tokens)
        return tokens
    }
}

extension OauthAuthManager {
    private func makeRefreshTokenRequest(refreshToken: String) throws -> URLRequest {
        var request = URLRequest(url: baseURL.appendingPathComponent("refresh-token"))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["refreshToken": refreshToken]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        return request
    }
    
    private func makeLoginRequest(username: String, password: String) throws -> URLRequest {
        var request = URLRequest(url: baseURL.appendingPathComponent("login"))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["username": username, "password": password]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        return request
    }
    
    private func execute(_ request: URLRequest) async throws -> AuthTokens {
        let (data, response) = try await urlSession.data(for: request)
        try validateResponse(response)
        
        do {
            return try jsonDecoder.decode(AuthTokens.self, from: data)
        } catch {
            throw AuthenticationError.invalidResponse
        }
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AuthenticationError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299: return
        case 400: throw AuthenticationError.invalidCredentials
        case 401: throw AuthenticationError.tokenExpired
        case 403: throw AuthenticationError.invalidRefreshToken
        case 500...599: throw AuthenticationError.serverError(statusCode: httpResponse.statusCode)
        default: throw AuthenticationError.invalidResponse
        }
    }
}

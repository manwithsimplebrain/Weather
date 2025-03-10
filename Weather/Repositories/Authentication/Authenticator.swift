//
//  Authenticator.swift
//  Networking
//
//  Created by Dat Doan on 5/3/25.
//

import Foundation

protocol Authenticator: Sendable {
    func refreshToken(_ refreshToken: String) async throws -> AuthTokens
    func login(username: String, password: String) async throws -> AuthTokens
}

public enum AuthenticationError: Error {
    case invalidCredentials
    case tokenExpired
    case invalidRefreshToken
    case networkError(Error)
    case serverError(statusCode: Int)
    case invalidResponse
}

//
//  TokenStorage.swift
//  Networking
//
//  Created by Dat Doan on 5/3/25.
//

import Foundation
import Security

protocol TokenStorage: Sendable {
    var isTokenExpired: Bool { get async }
    var accessToken: String? { get async }
    var refershToken: String? { get async }
    func update(tokens: AuthTokens) async
}

actor SecureTokenStorage: TokenStorage {
    @KeychainStorage(key: "tokens", defaultValue: nil) var tokens: AuthTokens?
    
    var isTokenExpired: Bool {
        get async {
            if let expireAt = tokens?.tokenExpiration {
                return Date().timeIntervalSince1970 > expireAt
            }
            return true
        }
    }

    var accessToken: String? {
        get async { return tokens?.accessToken }
    }

    var refershToken: String? {
        get async { return tokens?.refreshToken }
    }

    func update(tokens: AuthTokens) async {
        self.tokens = tokens
    }
}

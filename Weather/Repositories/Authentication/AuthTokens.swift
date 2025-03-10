//
//  AuthTokens.swift
//  Networking
//
//  Created by Dat Doan on 5/3/25.
//

import Foundation

public struct AuthTokens: Codable, Sendable {
    var accessToken: String?
    var refreshToken: String?
    var tokenExpiration: TimeInterval?
}

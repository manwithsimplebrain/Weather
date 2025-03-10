//
//  AuthRepImpl.swift
//  Weather
//
//  Created by Dat Doan on 6/3/25.
//

import Foundation

class AuthRepImpl: AuthRepository {
    private let authenticator: Authenticator
    
    init(authenticator: Authenticator) {
        self.authenticator = authenticator
    }
    
    func login(email: String, password: String) async throws {
        _ = try await authenticator.login(username: email, password: password)
    }
    
    func loginByAuthProvider(_ provider: AuthProvider) async throws {
        
    }
}

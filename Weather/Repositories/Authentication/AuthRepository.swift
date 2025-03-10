//
//  AuthRepository.swift
//  Weather
//
//  Created by Dat Doan on 6/3/25.
//

import Foundation

protocol AuthRepository {
    func login(email: String, password: String) async throws
    func loginByAuthProvider(_ provider: AuthProvider) async throws
}

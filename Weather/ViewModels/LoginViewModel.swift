//
//  LoginViewModel.swift
//  Weather
//
//  Created by Dat Doan on 6/3/25.
//

import Foundation
import Factory
import Networking

enum AuthProvider {
    case facebook
    case google
    case zalo
}

class LoginViewModel: ObservableObject {
    @Injected(\.authenticator) private var authenticator: Authenticator
    @Published var isloggedIn: Bool = false
    
    func login(username: String, password: String) {
        Task {
            do {
                _ = try await authenticator.login(username: username, password: password)
                await MainActor.run {
                    isloggedIn = true
                }
            } catch {
                print("Login faild error: \(error)")
            }
        }
    }
    
    func loginByAuthProvider(_ authProvider: AuthProvider) {
        
    }
}

//
//  RootViewModel.swift
//  Weather
//
//  Created by Dat Doan on 6/3/25.
//

import Foundation
import Factory
import Combine
import Supabase


class RootViewModel: ObservableObject {
    @Injected(\.tokenStorage) private var tokenStorage: TokenStorage
    @Published var tokenValid: Bool = false
    @Published var isCheckingToken: Bool = true
    @Published var loginViewModel: LoginViewModel = .init()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        registerObservers()
    }
    
    /// Check token after launch app
    func checkToken() async {
        Task { @MainActor in
            isCheckingToken = true
            let isExpired = await tokenStorage.isTokenExpired
            tokenValid = !isExpired
            isCheckingToken = false
        }
    }
}

extension RootViewModel {
    private func registerObservers() {
        loginViewModel.$isloggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoggedIn in
                // Chỉ cập nhật tokenValid nếu không đang kiểm tra token
                guard let self = self, !self.isCheckingToken else { return }
                self.tokenValid = isLoggedIn
            }
            .store(in: &cancellables)
    }
}

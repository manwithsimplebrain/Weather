//
//  WeatherDIContainer.swift
//  Weather
//
//  Created by Dat Doan on 3/3/25.
//

import Foundation
import Factory
import Networking

extension Container {
    var tokenStorage: Factory<TokenStorage> {
        Factory(self) { SecureTokenStorage() }
    }
    
    var authManager: Factory<AuthManager> {
        let baseURL = "http://localhost:3000/auth"
        return Factory(self) { OauthAuthManager(baseURL: baseURL, tokenStorage: self.tokenStorage()) }
    }
    
    var authenticator: Factory<Authenticator> {
        Factory(self) { self.authManager() as! Authenticator }
    }
    
    var urlSession: Factory<URLSession> {
        Factory(self) { URLSession.shared }
    }
    
    var firebaseProvider: Factory<FirebaseProvider> {
        Factory(self) { FirebaseProvider() }
    }
    
    var localStorage: Factory<LocalStorage> {
        Factory(self) { LocalFileStorage() }
    }
    
    /// Network service
    var networkService: Factory<NetworkService> {
        let config = DefaultNetworkServiceConfig(
            session: self.urlSession(),
            authManager: self.authManager()
        )
        return Factory(self) { NetworkService(config: config) }
    }
    
    /// Location service
    var locationService: Factory<LocationServiceable> {
        Factory(self) { LocationService() }
    }
    
    /// Authentication service
    var authenticationService: Factory<AuthenticationService> {
        Factory(self) { AuthenticationService() }
    }
    
    /// Tracking service
    var trackingService: Factory<TrackingService> {
        Factory(self) { TrackingService(providers: [self.firebaseProvider()]) }
    }
    
    /// Storage service
    var storageService: Factory<SupabaseStorage> {
        Factory(self) { SupabaseStorage(localStorage: self.localStorage()) }
    }
    
    var weatherRepository: Factory<WeatherRepository> {
        Factory(self) {
            OpenWeatherMapRepository()
        }
    }
    
    var geoRepository: Factory<GeoRepository> {
        Factory(self) {
            OpenStreetMapRepository()
        }
    }
}

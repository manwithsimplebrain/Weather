//
//  LocationService.swift
//  Weather
//
//  Created by Dat Doan on 2/3/25.
//

import Foundation
import CoreLocation

final class LocationService: NSObject, LocationServiceable {
    private let locationManager: CLLocationManager
    private var locationContinuation: CheckedContinuation<CLLocation, Error>?
    private var statusContinuation: CheckedContinuation<CLAuthorizationStatus, Error>?
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    /// Request authorization permission on first request
    func requestPermission() async throws -> CLAuthorizationStatus {
        try await withCheckedThrowingContinuation {[weak self] continuation in
            guard let self else {
                return continuation.resume(throwing: NSError()) // FIXME: Define error
            }
            
            let status = self.locationManager.authorizationStatus
            switch status {
            case .notDetermined:
                self.statusContinuation = continuation
                locationManager.requestWhenInUseAuthorization()
            case .denied, .restricted:
                continuation.resume(returning: status)
            case .authorizedWhenInUse, .authorizedAlways:
                continuation.resume(returning: status)
            @unknown default:
                fatalError("Must be implemented in a future release")
            }
        }
    }
    
    /// Request one-time user's location
    func requestCurrentLocation() async throws -> CLLocation {
        return try await withCheckedThrowingContinuation {[weak self] continuation in
            self?.locationContinuation = continuation
            self?.locationManager.requestLocation()
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationContinuation?.resume(returning: location)
        locationContinuation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationContinuation?.resume(throwing: error)
        locationContinuation = nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        statusContinuation?.resume(returning: status)
        statusContinuation = nil
    }
}

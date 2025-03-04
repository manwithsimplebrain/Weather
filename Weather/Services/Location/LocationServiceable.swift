//
//  LocationServiceable.swift
//  Weather
//
//  Created by Dat Doan on 3/3/25.
//

import Foundation
import CoreLocation

protocol LocationServiceable: AnyObject {
    func requestPermission() async throws -> CLAuthorizationStatus
    func requestCurrentLocation() async throws -> CLLocation
}

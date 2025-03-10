//
//  FirebaseProvider.swift
//  Weather
//
//  Created by Dat Doan on 10/3/25.
//

import Foundation
import FirebaseAnalytics

class FirebaseProvider: AnalyticsProvider {
    func initialize() { }

    func logEvent(_ event: AnalyticsEvent) {
        Analytics.logEvent(event.name, parameters: event.parameters)
    }
}

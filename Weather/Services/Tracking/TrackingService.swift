//
//  TrackingService.swift
//  Weather
//
//  Created by Dat Doan on 10/3/25.
//

import Foundation

final class TrackingService {
    private let queue = DispatchQueue(label: "analytics.engine.queue", attributes: .concurrent)
    private var providers: [AnalyticsProvider] = []
    
    init(providers: [AnalyticsProvider] = []) {
        self.providers = providers
        print("INIT TRAKING SERVICE")
    }
    
    func addProvider(_ provider: AnalyticsProvider) {
        queue.async(flags: .barrier) {[weak self] in
            self?.providers.append(provider)
            provider.initialize()
        }
    }
    
    func removeProvider(_ provider: AnalyticsProvider) {
        queue.async(flags: .barrier) {[weak self] in
            self?.providers.removeAll { $0 === provider }
        }
    }
    
    func logEvent(_ event: AnalyticsEvent) {
        queue.async {
            self.providers.forEach { $0.logEvent(event) }
        }
    }
}

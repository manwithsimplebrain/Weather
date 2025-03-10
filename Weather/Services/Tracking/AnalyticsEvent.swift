//
//  AnalyticsEvent.swift
//  Weather
//
//  Created by Dat Doan on 10/3/25.
//

import Foundation

protocol AnalyticsEvent {
    var name: String { get }
    var parameters: [String: Any]? { get }
}

struct DefaultEvent: AnalyticsEvent {
    var name: String
    var parameters: [String: Any]?
    
    init(name: String, parameters: [String: Any]? = nil) {
        self.name = name
        self.parameters = parameters
    }
}

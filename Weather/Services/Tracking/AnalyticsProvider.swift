//
//  AnalyticsProvider.swift
//  Weather
//
//  Created by Dat Doan on 10/3/25.
//

import Foundation

protocol AnalyticsProvider: AnyObject {
    func initialize()
    func logEvent(_ event: AnalyticsEvent)
}

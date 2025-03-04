//
//  String+Localization.swift
//  Weather
//
//  Created by Dat Doan on 4/3/25.
//

import Foundation

extension String {
    var localized: String {
        return String(localized: String.LocalizationValue(self))
    }
}

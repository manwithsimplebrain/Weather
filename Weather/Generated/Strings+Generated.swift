// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Localizable.strings
  ///   Weather
  /// 
  ///   Created by Dat Doan on 4/3/25.
  internal static let humidity = L10n.tr("Localizable", "humidity", fallback: "Humidity")
  /// Last update at:
  internal static let lastUpdateAt = L10n.tr("Localizable", "last_update_at", fallback: "Last update at:")
  /// Max Temp
  internal static let maxTemp = L10n.tr("Localizable", "max_temp", fallback: "Max Temp")
  /// Min Temp
  internal static let minTemp = L10n.tr("Localizable", "min_temp", fallback: "Min Temp")
  /// Pressure
  internal static let pressure = L10n.tr("Localizable", "pressure", fallback: "Pressure")
  /// Settings
  internal static let settings = L10n.tr("Localizable", "settings", fallback: "Settings")
  /// Temperture
  internal static let temperture = L10n.tr("Localizable", "temperture", fallback: "Temperture")
  /// Today’s Weather
  internal static let todayWeather = L10n.tr("Localizable", "today_weather", fallback: "Today’s Weather")
  /// Weather
  internal static let weather = L10n.tr("Localizable", "weather", fallback: "Weather")
  /// Wind Speed
  internal static let windSpeed = L10n.tr("Localizable", "wind_speed", fallback: "Wind Speed")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

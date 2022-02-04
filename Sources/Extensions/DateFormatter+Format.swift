//
//  DateFormatter+Format.swift
//  Meditation
//

import Foundation

private extension Constants {
  static let hoursMinutes = "HH:mm"
}

extension DateFormatter {
  static let hoursMinutes = dateFormatter(format: Constants.hoursMinutes)
  private static func dateFormatter(format: String) -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.locale = .current
    return dateFormatter
  }
}

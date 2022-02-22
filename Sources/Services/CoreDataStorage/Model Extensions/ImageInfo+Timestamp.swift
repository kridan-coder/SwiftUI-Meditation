//
//  ImageInfo+Timestamp.swift
//  Meditation
//

import Foundation
import CoreData

extension ImageInfo {
  func timestampString(dateFormatter: DateFormatter = .hoursMinutes) -> String? {
    guard let timestamp = timestamp else { return nil }
    return dateFormatter.string(from: timestamp)
  }
}

//
//  Constants.swift
//  Meditation
//
//  Created by Daniel Krivelev on 30.01.2022.
//

import Foundation

enum Constants {
  static var enableLoggingToConsole: Bool {
    if let configuration = Bundle.main.infoDictionary?["Configuration"] as? String,
        configuration == "Debug" {
      return true
    }
    return false
  }
}

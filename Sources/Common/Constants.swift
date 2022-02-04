//
//  Constants.swift
//  Meditation
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

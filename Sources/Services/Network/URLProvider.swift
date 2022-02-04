//
//  URLProvider.swift
//  Meditation
//

import Foundation

final class URLProvider {
  enum BaseURL: String {
    case test = "http://mskko2021.mad.hakta.pro/api/"
    case anotherTest = "http://mskko2022.mad.hakta.pro/api/" // can be switched to this (will not work though)
  }
  
  private var defaultBaseURL: BaseURL
  private let userDefaults: UserDefaults
  
  private struct URLProviderUserDefaultsKeys {
    static let defaultBaseURL = "defaultBaseURL"
  }
  
  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
    guard let userDefaultsBaseURL = userDefaults.string(forKey: URLProviderUserDefaultsKeys.defaultBaseURL),
          let convertedUserDefaultsBaseURL = BaseURL(rawValue: userDefaultsBaseURL) else {
            defaultBaseURL = BaseURL.test
            return
          }
    defaultBaseURL = convertedUserDefaultsBaseURL
  }
  
  var currentBaseURL: String {
    get {
      defaultBaseURL.rawValue
    }
    set {
      guard let newDefaultBaseURL = BaseURL(rawValue: newValue) else { return }
      defaultBaseURL = newDefaultBaseURL
      userDefaults.set(newDefaultBaseURL, forKey: URLProviderUserDefaultsKeys.defaultBaseURL)
    }
  }
  
  func makeURL(with urlPart: String) -> String {
    currentBaseURL + urlPart
  }
  
} 

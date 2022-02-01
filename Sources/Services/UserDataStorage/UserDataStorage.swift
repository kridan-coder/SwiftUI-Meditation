//
//  UserDataStorage.swift
//  Meditation
//
//  Created by Daniel Krivelev on 01.02.2022.
//

import Foundation
import KeychainAccess

final class UserDataStorage: UserDataStoring {
  private struct KeychainKeys {
    static let accessToken = "accessToken"
  }
  
  private struct UserDefaultsKeys {
    static let hadFirstRunAlready = "hadFirstRunAlready"
  }
  
  private let keychain: Keychain
  private let userDefaults: UserDefaults
  
  @Keychained(key: KeychainKeys.accessToken)
  var accessToken: String?
  
  var isLoggedIn: Bool {
    accessToken != nil
  }
  
  @UserDefault(key: UserDefaultsKeys.hadFirstRunAlready, defaultValue: false)
  var hadFirstRunAlready: Bool
  
  @UserDefault(key: UserDefaultsKeys.hadFirstRunAlready, defaultValue: nil)
  var nickname: String?
  
  @UserDefault(key: UserDefaultsKeys.hadFirstRunAlready, defaultValue: nil)
  var avatarURL: URL?
  
  init(userDefaults: UserDefaults = UserDefaults.standard, keychain: Keychain = Keychain()) {
    self.keychain = keychain
    self.userDefaults = userDefaults
  }
  
  private func handleFirstLaunch() {
    if !hadFirstRunAlready {
      hadFirstRunAlready = true
    }
  }
  
}

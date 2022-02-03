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
    static let nickname = "nickname"
    static let avatarURL = "avatarURL"
    static let email = "email"
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
  
  @UserDefault(key: UserDefaultsKeys.nickname, defaultValue: nil)
  var nickname: String?
  
  @UserDefault(key: UserDefaultsKeys.avatarURL, defaultValue: nil)
  var avatarURL: String?
  
  @UserDefault(key: UserDefaultsKeys.email, defaultValue: nil)
  var email: String?
  
  init(userDefaults: UserDefaults = UserDefaults.standard, keychain: Keychain = Keychain()) {
    self.keychain = keychain
    self.userDefaults = userDefaults
  }
  
  func clearData() {
    nickname = nil
    avatarURL = nil
    email = nil
    accessToken = nil
  }
  
}

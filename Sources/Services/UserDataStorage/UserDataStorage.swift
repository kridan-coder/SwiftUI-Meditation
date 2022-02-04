//
//  UserDataStorage.swift
//  Meditation
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
  
  @UserDefault(key: UserDefaultsKeys.nickname, defaultValue: "")
  var nickname: String
  
  @UserDefault(key: UserDefaultsKeys.avatarURL, defaultValue: "")
  var avatarURL: String
  
  @UserDefault(key: UserDefaultsKeys.email, defaultValue: "")
  var email: String
  
  init(userDefaults: UserDefaults = UserDefaults.standard, keychain: Keychain = Keychain()) {
    self.keychain = keychain
    self.userDefaults = userDefaults
  }
  
  func clearData() {
    nickname = ""
    avatarURL = ""
    email = ""
    accessToken = nil
  }
  
}

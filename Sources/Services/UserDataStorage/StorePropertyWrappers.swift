//
//  StorePropertyWrappers.swift
//  Meditation
//

import Foundation
import KeychainAccess

@propertyWrapper
struct UserDefault<Value> {
  let key: String
  let defaultValue: Value
  var container: UserDefaults = .standard
  
  var wrappedValue: Value {
    get {
      container.object(forKey: key) as? Value ?? defaultValue
    }
    set {
      container.set(newValue, forKey: key)
    }
  }
  
}

@propertyWrapper
struct Keychained {
  let key: String
  var keychain: Keychain
  
  init(key: String, keychain: Keychain = Keychain()) {
    self.key = key
    self.keychain = keychain
  }
  
  var wrappedValue: String? {
    get {
      var token: String?
      do {
        token = try keychain.getString(key)
      } catch let error {
        log?.error("Error while getting value for \(key), error: \(error)")
      }
      return token
    }
    set {
      guard let newValue = newValue else {
        try? keychain.remove(key)
        return
      }
      do {
        try keychain.set(newValue, key: key)
      } catch let error {
        log?.error("Error while setting value: \(newValue) for \(key), error: \(error)")
      }
    }
  }
  
}

//
//  AppDependencies.swift
//  Meditation
//

import SwiftUI

final class AppDependencies: ObservableObject {
  private let realmStorage: RealmStorage
  private let storageService: StorageService
  private let networkService: NetworkService
  private let userStorage: UserDataStorage
  
  var authNetworkService: AuthNetworkProtocol {
    networkService
  }
  
  var quotesNetworkService: QuotesNetworkProtocol {
    networkService
  }
  
  var feelingsNetworkService: FeelingsNetworkProtocol {
    networkService
  }
  
  var uiImagesStorage: UIImagesStoring {
    storageService
  }
  
  var realmService: RealmServiceProviding {
    realmStorage
  }
  
  var userDataStorageService: UserDataStoring {
    userStorage
  }
  
  init(realmStorage: RealmStorage, storageService: StorageService, networkService: NetworkService, userStorage: UserDataStorage) {
    self.realmStorage = realmStorage
    self.storageService = storageService
    self.networkService = networkService
    self.userStorage = userStorage
  }
  
  static func makeDefault() -> AppDependencies {
    AppDependencies(realmStorage: RealmStorage(),
                    storageService: StorageService(),
                    networkService: NetworkService(),
                    userStorage: UserDataStorage())
  }
  
}

private struct AppDependenciesKey: EnvironmentKey {
  static let defaultValue = AppDependencies.makeDefault()
}

extension EnvironmentValues {
  var appDependencies: AppDependencies {
    self[AppDependenciesKey.self]
  }
}

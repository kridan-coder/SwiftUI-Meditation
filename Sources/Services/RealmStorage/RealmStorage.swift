//
//  RealmStorage.swift
//  Meditation
//
//  Created by Daniel Krivelev on 01.02.2022.
//

import Foundation
import RealmSwift

struct RealmStorage: RealmServiceProviding {
  private let realm: Realm
  
  init(realm: Realm) {
    self.realm = realm
  }
  
  init() {
    do {
      self.realm = try Realm()
    } catch let error {
      fatalError(error.localizedDescription)
    }
  }
  
  func add<T: Object>(_ object: T) throws {
    do {
      try realm.write {
        realm.add(object, update: .error)
      }
    } catch let error {
      log?.error(error)
      throw StorageError.couldNotSaveFile
    }
  }
  
  func getAllObjects<T: Object>(ofType type: T.Type) -> [T] {
    Array(realm.objects(type))
  }
  
  func delete<T: Object>(_ object: T) throws {
    do {
      try realm.write {
        realm.delete(object)
      }
    } catch let error {
      log?.error(error)
      throw StorageError.couldNotClearStorage
    }
  }
  
  func deleteAllObjects<T: Object>(ofType type: T.Type) throws {
    let allObjects = realm.objects(type)
    do {
      try realm.write {
        realm.delete(allObjects)
      }
    } catch let error {
      log?.error(error)
      throw StorageError.couldNotClearStorage
    }
  }
  
}

//
//  RealmServiceProviding.swift
//  Meditation
//

import Foundation
import RealmSwift

protocol RealmServiceProviding {
  func add<T: Object>(_ object: T) throws
  func getAllObjects<T: Object>(ofType type: T.Type) -> [T]
  func delete<T: Object>(_ object: T) throws
  func deleteAllObjects<T: Object>(ofType type: T.Type) throws
}

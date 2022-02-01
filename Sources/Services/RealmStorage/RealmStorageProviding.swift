//
//  RealmStorageProviding.swift
//  Meditation
//
//  Created by Daniel Krivelev on 01.02.2022.
//

import Foundation
import RealmSwift

protocol RealmStorageProviding {
  func createOrUpdate<T: Object>(_ object: T) throws
  func getAllObjects<T: Object>(ofType type: T.Type) -> [T]
  func deleteAllObjects<T: Object>(ofType type: T.Type) throws 
}

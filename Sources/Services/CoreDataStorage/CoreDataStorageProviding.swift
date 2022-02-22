//
//  CoreDataStorageProviding.swift
//  Meditation
//

import Foundation
import CoreData

protocol CoreDataStorageProviding {
  var viewContext: NSManagedObjectContext { get }
}

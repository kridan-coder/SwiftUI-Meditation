//
//  CoreDataStorage.swift
//  Meditation
//

import Foundation
import CoreData

struct CoreDataStorage: CoreDataStorageProviding {
  let container = NSPersistentContainer(name: "Meditation")
  
  var viewContext: NSManagedObjectContext {
    container.viewContext
  }
  
  init() {
    container.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Core Data failed to load: \(error.localizedDescription)")
      }
    }
  }
}

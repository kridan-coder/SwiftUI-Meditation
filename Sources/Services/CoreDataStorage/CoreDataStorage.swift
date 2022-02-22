//
//  CoreDataStorage.swift
//  Meditation
//

import Foundation
import CoreData

final class CoreDataStorage: CoreDataStorageProviding {
  let container = NSPersistentContainer(name: "Meditation")
  
  var viewContext: NSManagedObjectContext {
    container.viewContext
  }
  
  init() {
    container.loadPersistentStores { description, error in
      log?.debug(description)
      if let error = error {
        fatalError("Core Data failed to load: \(error.localizedDescription)")
      }
    }
  }
}

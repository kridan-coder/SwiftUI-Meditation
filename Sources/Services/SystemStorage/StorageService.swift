//
//  StorageService.swift
//  Meditation
//
//  Created by Daniel Krivelev on 31.01.2022.
//

import Foundation

final class StorageService {
  enum Keys: String {
    case image
  }
  
  let imagesStorage = Storage<Data>(folderName: "Images")
  
  func generateFileName(for type: Keys, name: String) -> String {
    type.rawValue + "_" + name
  }
  
}

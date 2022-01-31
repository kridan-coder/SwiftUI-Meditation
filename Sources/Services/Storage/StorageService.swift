//
//  StorageService.swift
//  Meditation
//
//  Created by Daniel Krivelev on 31.01.2022.
//

import Foundation

final class StorageService {
  private enum Keys: String {
    case images
  }
  
  private let imagesStorage = Storage<Data>()
  
  
}

//
//  StorageError.swift
//  Meditation
//
//  Created by Daniel Krivelev on 31.01.2022.
//

import Foundation

enum StorageError: Error {
  case noSavedData
  case couldNotSaveFile
}

extension StorageError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .noSavedData:
      return R.string.storageErrors.errorNoSavedDataText()
    case .couldNotSaveFile:
      return R.string.storageErrors.errorCouldNotSaveFileText()
    }
  }
  
}

//
//  StorageError.swift
//  Meditation
//

import Foundation

enum StorageError: Error {
  case noSavedData
  case couldNotSaveFile
  case couldNotClearStorage
  case couldNotDecodeFile
}

extension StorageError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .noSavedData:
      return R.string.storageErrors.errorNoSavedDataText()
    case .couldNotSaveFile:
      return R.string.storageErrors.errorCouldNotSaveFileText()
    case .couldNotClearStorage:
      return R.string.storageErrors.errorCouldNotClearStorageText()
    case .couldNotDecodeFile:
      return R.string.storageErrors.errorCouldNotDecodeFileText()
    }
  }
  
}

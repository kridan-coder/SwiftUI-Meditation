//
//  Storage.swift
//  Meditation
//

import Foundation

struct Storage<T: Codable> {
  private let fileManager = FileManager.default
  private let folderName: String
  private let decoder: JSONDecoder
  private let encoder: JSONEncoder
  
  init(folderName: String = String(describing: T.self),
       decoder: JSONDecoder = JSONDecoder(),
       encoder: JSONEncoder = JSONEncoder()) {
    self.folderName = folderName
    self.decoder = decoder
    self.encoder = encoder
  }
  
  func setObject(_ object: T, forKey key: String) throws {
    let fileURL = try directoryURL().appendingPathComponent(key, isDirectory: false)
    let data = try encoder.encode(object)
    if fileManager.fileExists(atPath: fileURL.path) {
      try fileManager.removeItem(at: fileURL) // delete existing
    }
    let result = fileManager.createFile(atPath: fileURL.path, contents: data)
    guard result else {
      throw StorageError.couldNotSaveFile
    }
  }
  
  func object(forKey key: String) throws -> T {
    let fileURL = try directoryURL().appendingPathComponent(key, isDirectory: false)
    guard let data = fileManager.contents(atPath: fileURL.path) else {
      throw StorageError.noSavedData
    }
    return try decoder.decode(T.self, from: data)
  }
  
  func objects() throws -> [T] {
    var result: [T] = []
    let folderURL = try directoryURL()
    let contents = try fileManager.contentsOfDirectory(atPath: folderURL.path)
    for filePath in contents {
      guard let data = fileManager.contents(atPath: filePath) else {
        continue
      }
      let object = try decoder.decode(T.self, from: data)
      result.append(object)
    }
    guard !result.isEmpty else {
      throw StorageError.noSavedData
    }
    return result
  }
  
  func deleteObject(withKey key: String) throws {
    let fileURL = try directoryURL().appendingPathComponent(key, isDirectory: false)
    if fileManager.fileExists(atPath: fileURL.path) {
      try fileManager.removeItem(at: fileURL)
    }
  }
  
  func clearAllData() throws {
    let folderURL = try directoryURL()
    let contents = try fileManager.contentsOfDirectory(atPath: folderURL.path)
    for filePath in contents {
      let fullFileURL = folderURL.appendingPathComponent(filePath, isDirectory: false)
      try fileManager.removeItem(at: fullFileURL)
    }
  }
  
  private func directoryURL() throws -> URL {
    var directoryURL = try fileManager.url(for: .documentDirectory,
                                           in: .userDomainMask,
                                           appropriateFor: nil,
                                           create: true).appendingPathComponent(folderName, isDirectory: true)
    try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
    var resourceValues = URLResourceValues()
    resourceValues.isExcludedFromBackup = true
    try directoryURL.setResourceValues(resourceValues)
    return directoryURL
  }
  
}

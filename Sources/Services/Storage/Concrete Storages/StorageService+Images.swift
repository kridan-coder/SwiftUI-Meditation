//
//  StorageService+Images.swift
//  Meditation
//
//  Created by Daniel Krivelev on 01.02.2022.
//

import Foundation
import UIKit

extension StorageService: UIImagesStoring {
  func store(uiImage: UIImage, name: String) throws {
    let key = generateFileName(for: .image, name: name)
    guard let data = uiImage.pngData() ?? uiImage.jpegData(compressionQuality: 1) else {
      throw StorageError.couldNotSaveFile
    }
    try imagesStorage.setObject(data, forKey: key)
  }
  
  func getUIImage(with name: String) throws -> UIImage {
    let key = generateFileName(for: .image, name: name)
    let data = try imagesStorage.object(forKey: key)
    guard let image = UIImage(data: data) else {
      throw StorageError.couldNotDecodeFile
    }
    return image
  }
  
  func getUIImages() throws -> [UIImage] {
    let data = try imagesStorage.objects()
    let images = data.compactMap { UIImage(data: $0) }
    return images
  }
  
  func clearImagesData() throws {
    do {
      try imagesStorage.clearAllData()
    } catch {
      throw StorageError.couldNotClearStorage
    }
  }
  
}

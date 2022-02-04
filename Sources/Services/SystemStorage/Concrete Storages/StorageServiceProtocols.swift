//
//  StorageServiceProtocols.swift
//  Meditation
//

import Foundation
import UIKit

protocol UIImagesStoring {
  func store(uiImage: UIImage, name: String) throws
  func deleteImage(withName name: String) throws
  func getUIImage(withKey key: String) throws -> UIImage
  func getUIImages() throws -> [UIImage]
  func clearImagesData() throws
}

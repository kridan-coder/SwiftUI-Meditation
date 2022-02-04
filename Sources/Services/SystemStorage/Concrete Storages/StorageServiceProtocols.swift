//
//  StorageServiceProtocols.swift
//  Meditation
//
//  Created by Daniel Krivelev on 31.01.2022.
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

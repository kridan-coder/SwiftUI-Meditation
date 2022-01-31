//
//  StorageServiceProtocols.swift
//  Meditation
//
//  Created by Daniel Krivelev on 31.01.2022.
//

import Foundation
import UIKit

protocol UIImagesStoring {
  func store(uiImage: UIImage) throws
  func getUIImage(with key: String) throws -> UIImage
  func getUIImages() throws -> UIImage
  func clearImagesData()
}

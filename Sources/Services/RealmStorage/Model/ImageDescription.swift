//
//  ImageDescription.swift
//  Meditation
//

import RealmSwift
import Foundation

class ImageDescription: Object, ObjectKeyIdentifiable {
  @objc dynamic var name: String = ""
  @objc dynamic var time: String = ""
}

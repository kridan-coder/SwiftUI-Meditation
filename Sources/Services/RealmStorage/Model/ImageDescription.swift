//
//  ImageDescription.swift
//  Meditation
//
//  Created by Daniel Krivelev on 04.02.2022.
//

import RealmSwift

class ImageDescription: Object, ObjectKeyIdentifiable {
  @objc dynamic var name: String = ""
  @objc dynamic var time: String = ""
}

//
//  Image+CustomInit.swift
//  Meditation
//

import SwiftUI

extension Image {
  init(_ imageResource: AppImageResource) {
    self.init(imageResource.rawValue)
  }
}

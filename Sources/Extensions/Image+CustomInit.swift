//
//  Image+CustomInit.swift
//  Meditation
//
//  Created by Daniel Krivelev on 02.02.2022.
//

import SwiftUI

extension Image {
  init(_ imageResource: AppImageResource) {
    self.init(imageResource.rawValue)
  }
}

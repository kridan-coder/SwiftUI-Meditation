//
//  ChoiceCellModel.swift
//  Meditation
//
//  Created by Daniel Krivelev on 16.01.2022.
//

import Foundation
import SwiftUI

struct ChoiceCellModel: Identifiable {
  let id = UUID()
  let title: String
  let imageURL: URL
}

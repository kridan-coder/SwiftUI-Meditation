//
//  CardCellModel.swift
//  Meditation
//

import SwiftUI

struct CardCellModel: Identifiable {
  let title: String
  let description: String
  let imageURL: URL
  
  let serverID: Int
  let id = UUID()
}

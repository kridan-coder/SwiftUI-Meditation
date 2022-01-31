//
//  Feelings.swift
//  Meditation
//
//  Created by Daniel Krivelev on 31.01.2022.
//

import Foundation

struct Feelings: Decodable {
  let success: Bool
  let data: [FeelingData]
}

struct FeelingData: Decodable {
  let id: Int
  let title: String
  let image: URL
  let position: Int
}

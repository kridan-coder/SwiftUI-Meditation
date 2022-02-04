//
//  Feelings.swift
//  Meditation
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

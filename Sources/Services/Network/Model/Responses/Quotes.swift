//
//  Quotes.swift
//  Meditation
//

import Foundation

struct Quotes: Decodable {
  let success: Bool
  let data: [QuoteData]
}

struct QuoteData: Decodable {
  let id: Int
  let title: String
  let image: URL
  let description: String
}

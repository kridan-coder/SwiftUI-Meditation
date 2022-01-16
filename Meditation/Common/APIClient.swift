//
//  APIClient.swift
//  Meditation
//
//  Created by Daniel Krivelev on 16.01.2022.
//

import Foundation
import Alamofire


struct Quotes: Codable {
  let success: Bool
  let data: [QuoteData]
}

struct QuoteData: Codable {
  let id: Int
  let title: String
  let image: URL
  let description: String
}

struct Feelings: Codable {
  let success: Bool
  let data: [FeelingData]
}

struct FeelingData: Codable {
  let id: Int
  let title: String
  let image: URL
  let position: Int
}

final class APIClient {
  let baseLink = "http://mskko2021.mad.hakta.pro/api/"
  
  func getQuotes(completion: @escaping (Quotes) -> Void) {
    AF.request(baseLink + "quotes", method: .get).response { response in
      switch response.result {case .success(let data):
        completion(try! JSONDecoder().decode(Quotes.self, from: data!))
      case .failure(_):
        return
      }
    }
  }
  
  func getFeelings(completion: @escaping (Feelings) -> Void) {
    AF.request(baseLink + "feelings", method: .get).response { response in
      switch response.result {case .success(let data):
        completion(try! JSONDecoder().decode(Feelings.self, from: data!))
      case .failure(_):
        return
      }
    }
  }
  
}

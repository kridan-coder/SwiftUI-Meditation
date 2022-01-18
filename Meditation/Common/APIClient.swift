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

struct ReceivedUserData: Codable {
  let id: String
  let email: String
  let nickName: String
  let avatar: String
  let token: String
}

struct UserDataToSend: Codable {
  let email: String
  let password: String
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
  
  func login(email: String, password: String, completion: @escaping (Result<ReceivedUserData, Error>) -> Void) {
    let dataToSend = UserDataToSend(email: email, password: password)
    let headers: HTTPHeaders = ["Content-Type" : "application/json"]
    AF.request(baseLink + "user/login", method: .post, parameters: dataToSend, encoder: JSONParameterEncoder.default, headers: headers)
      .validate(statusCode: 200..<250)
      .response { response in
      switch response.result {case .success(let data):
        print(data?.description)
        completion(.success(try! JSONDecoder().decode(ReceivedUserData.self, from: data!)))
      case .failure(let error):
        print(error.errorDescription)
        completion(.failure(error))
      }
    }
  }
  
}

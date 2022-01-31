//
//  NetworkServiceProtocols.swift
//  Meditation
//

import Foundation
import PromiseKit

protocol QuotesNetworkProtocol {
  func getAllQuotes() -> Promise<Quotes>
}

protocol FeelingsNetworkProtocol {
  func getAllFeelings() -> Promise<Feelings>
}

protocol AuthNetworkProtocol {
  func login(email: String, password: String) -> Promise<ReceivedUserData>
}

//
//  NetworkServiceProtocols.swift
//  Meditation
//

import Foundation

protocol QuotesNetworkProtocol {
  func getAllQuotes() async throws -> Quotes
}

protocol FeelingsNetworkProtocol {
  func getAllFeelings() async throws -> Feelings
}

protocol AuthNetworkProtocol {
  func login(email: String, password: String) async throws -> ReceivedUserData
}

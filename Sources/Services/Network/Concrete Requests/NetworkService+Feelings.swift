//
//  NetworkService+Feelings.swift
//  Meditation
//

import Foundation

extension NetworkService: FeelingsNetworkProtocol {
  func getAllFeelings() async throws -> Feelings {
    let url = urlProvider.makeURL(with: URLFactory.Feelings.getAllFeelings)
    return try await execute(url: url, method: .get)
  }
  
}

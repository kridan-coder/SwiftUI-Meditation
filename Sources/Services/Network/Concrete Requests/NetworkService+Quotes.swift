//
//  NetworkService+Quotes.swift
//  Meditation
//

import Foundation

extension NetworkService: QuotesNetworkProtocol {
  func getAllQuotes() async throws -> Quotes {
    let url = urlProvider.makeURL(with: URLFactory.Quotes.getAllQuotes)
    return try await execute(url: url, method: .get)
  }
  
}

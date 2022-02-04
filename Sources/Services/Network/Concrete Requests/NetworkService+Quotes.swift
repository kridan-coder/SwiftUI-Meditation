//
//  NetworkService+Quotes.swift
//  Meditation
//

import Foundation
import PromiseKit

extension NetworkService: QuotesNetworkProtocol {
  func getAllQuotes() -> Promise<Quotes> {
    let url = urlProvider.makeURL(with: URLFactory.Quotes.getAllQuotes)
    return execute(url: url, method: .get)
  }
  
}

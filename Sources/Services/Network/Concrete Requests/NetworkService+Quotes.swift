//
//  NetworkService+Quotes.swift
//  Meditation
//
//  Created by Daniel Krivelev on 31.01.2022.
//

import Foundation
import PromiseKit

extension NetworkService: QuotesNetworkProtocol {
  func getAllQuotes() -> Promise<Quotes> {
    let url = urlProvider.makeURL(with: URLFactory.Quotes.getAllQuotes)
    return execute(url: url, method: .get)
  }
  
}

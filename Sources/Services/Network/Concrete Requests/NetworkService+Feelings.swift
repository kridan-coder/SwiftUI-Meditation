//
//  NetworkService+Feelings.swift
//  Meditation
//

import Foundation
import PromiseKit

extension NetworkService: FeelingsNetworkProtocol {
  func getAllFeelings() -> Promise<Feelings> {
    let url = urlProvider.makeURL(with: URLFactory.Feelings.getAllFeelings)
    return execute(url: url, method: .get)
  }
  
}

//
//  NetworkService+Feelings.swift
//  Meditation
//
//  Created by Daniel Krivelev on 31.01.2022.
//

import Foundation
import PromiseKit

extension NetworkService: FeelingsNetworkProtocol {
  func getAllFeelings() -> Promise<Feelings> {
    let url = urlProvider.makeURL(with: URLFactory.Feelings.getAllFeelings)
    return execute(url: url, method: .get)
  }
  
}

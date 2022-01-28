//
//  NetworkServiceError.swift
//  Meditation
//
//  Created by Daniel Krivelev on 28.01.2022.
//

import Foundation
import Accelerate

enum NetworkServiceError: Error {
  case unknown
  case noDataReceived
  case failedToDecode
}

extension NetworkServiceError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .unknown:
      <#code#>
    case .noDataReceived:
      <#code#>
    case .failedToDecode:
      <#code#>
    }
  }
}

//
//  NetworkServiceError.swift
//  Meditation
//
//  Created by Daniel Krivelev on 28.01.2022.
//

import Foundation

enum NetworkServiceError: Error {
  case unknown
  case noDataReceived
  case failedToDecode
}

extension NetworkServiceError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .unknown:
      return R.string.networkErrors.errorUnknownText()
    case .noDataReceived:
      return R.string.networkErrors.errorNoDataReceivedText()
    case .failedToDecode:
      return R.string.networkErrors.errorDecodingText()
    }
  }
}

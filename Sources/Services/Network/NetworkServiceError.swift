//
//  NetworkServiceError.swift
//  Meditation
//

import Foundation

enum NetworkServiceError: Error {
  case unknown
  case noDataReceived
  case failedToDecode
  case invalidURL
  
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
    case .invalidURL:
      return R.string.networkErrors.errorDecodingText()
    }
  }
  
}

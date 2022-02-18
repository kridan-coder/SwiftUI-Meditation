//
//  NetworkErrorService.swift
//  Meditation
//

import Foundation

extension Constants {
  fileprivate static let AlamofireNoInternetErrorCode = 13
}

final class NetworkErrorService {
  enum StatusCode: Int {
    case okStatus = 200
    case okCreated = 201
    case okAccepted = 202
    case okNoContent = 204
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case conflict = 409
    case internalError = 500
    case badGateway = 502
  }
  
  private init() {}
  
  static let networkErrorDomain = "MeditationNetworkError"
  
  static let offlineError: Error = {
    let message = R.string.networkErrors.errorNoInternetText()
    let userInfo = [NSLocalizedDescriptionKey: message]
    return NSError(domain: networkErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: userInfo) as Error
  }()
  
  static func isOfflineError(_ error: Error) -> Bool {
    let errorCodes = [NSURLErrorNotConnectedToInternet, NSURLErrorCannotConnectToHost, NSURLErrorTimedOut,
                      NSURLErrorCannotFindHost, NSURLErrorCallIsActive, NSURLErrorNetworkConnectionLost,
                      NSURLErrorDataNotAllowed, NSURLErrorCannotLoadFromNetwork,
                      NSURLErrorInternationalRoamingOff, NSURLErrorSecureConnectionFailed,
                      Constants.AlamofireNoInternetErrorCode]
    if let dataRequestError = error as? RequestError {
      let afError = dataRequestError.alamofireError
      if let underlyingError = afError.underlyingError {
        return errorCodes.contains((underlyingError as NSError).code)
      }
      return errorCodes.contains((afError as NSError).code)
    }

    return errorCodes.contains((error as NSError).code)
  }
}

//
//  NetworkService.swift
//  Meditation
//

import Foundation
import Alamofire
import PromiseKit

final class NetworkService {
  enum RequestType {
    case common, authorization
  }
  
  private enum HeaderKeys {
    static let contentType = "Content-Type"
  }
  
  private enum HeaderValues {
    static let contentType = "application/json"
  }
  
  let urlProvider: URLProvider
  private let decoder: JSONDecoder
  
  // MARK: - Init
  init(urlProvider: URLProvider = URLProvider(), decoder: JSONDecoder = JSONDecoder()) {
    self.urlProvider = urlProvider
    self.decoder = decoder
  }
  
  // MARK: - Request
  func execute<Response: Decodable>(url: String,
                                    method: HTTPMethod,
                                    headers: [String: String] = [:],
                                    requestType: RequestType = .common) -> Promise<Response> {
    guard let url = URL(string: url) else {
      return Promise(error: NetworkServiceError.invalidURL)
    }
    let request = AF.request(url, method: method, headers: modifiedHeaders(from: headers, requestType: requestType))
    return Promise { seal in
      firstly {
        request.responseDataAsPromise()
      }.then { response in
        self.handleResponse(response)
      }.done { result in
        seal.fulfill(result)
      }.catch { error in
        seal.reject(error)
      }
    }
    
  }
  
  func execute <Request: Encodable,
                Response: Decodable> (url: String,
                                      method: HTTPMethod,
                                      parameters: Request,
                                      encoder: ParameterEncoder = JSONParameterEncoder.default,
                                      headers: [String: String] = [:],
                                      requestType: RequestType = .common) -> Promise<Response> {
    guard let url = URL(string: url) else {
      return Promise(error: NetworkServiceError.invalidURL)
    }
    let request = AF.request(url, method: method,
                             parameters: parameters,
                             encoder: encoder,
                             headers: modifiedHeaders(from: headers, requestType: requestType))
      .validate(statusCode: 200..<250)
    return Promise { seal in
      firstly {
        request.responseDataAsPromise()
      }.then { response in
        self.handleResponse(response)
      }.done { result in
        seal.fulfill(result)
      }.catch { error in
        seal.reject(error)
      }
    }
  }
  
  private func handleResponse<Response: Decodable>(_ response: AFDataResponse<Data>) -> Promise<Response> {
    switch response.result {
    case .success(let data):
      do {
        let decodedData = try decoder.decode(Response.self, from: data)
        return Promise.value(decodedData)
      } catch let error {
        log?.error(error)
        return Promise(error: NetworkServiceError.failedToDecode)
      }
    case .failure(let error):
      log?.error(error)
      return Promise(error: NetworkServiceError.unknown)
    }
  }
  
  // MARK: - Headers
  private func modifiedHeaders(from headers: [String: String], requestType: RequestType) -> HTTPHeaders? {
    var headers = headers
    if requestType == .authorization {
      headers[HeaderKeys.contentType] = HeaderValues.contentType
    }
    guard !headers.isEmpty else {
      return nil
    }
    return HTTPHeaders(headers)
  }
  
}

//
//  NetworkService.swift
//  Meditation
//

import Foundation
import Alamofire

final class NetworkService {
  private enum RequestType {
    case common, authorization
  }
  
  private enum HeaderKeys {
    static let contentType = "Content-Type"
  }
  
  private enum HeaderValues {
    static let contentType = "application/json"
  }
  
  private let urlProvider: URLProvider
  private let decoder: JSONDecoder
  
  // MARK: - Init
  init(urlProvider: URLProvider = URLProvider(), decoder: JSONDecoder = JSONDecoder()) {
    self.urlProvider = urlProvider
    self.decoder = decoder
  }
  
  // MARK: - Quotes
  func getQuotes(completionHandler: @escaping (Result<Quotes, NetworkServiceError>) -> Void) {
    let url = urlProvider.makeURL(with: URLFactory.Quotes.getAllQuotes)
    execute(url: url, method: .get) { result in
      completionHandler(result)
    }
  }
  
  // MARK: - Feelings
  func getFeelings(completionHandler: @escaping (Result<Feelings, NetworkServiceError>) -> Void) {
    let url = urlProvider.makeURL(with: URLFactory.Feelings.getAllFeelings)
    execute(url: url, method: .get) { result in
      completionHandler(result)
    }
  }
  
  // MARK: - User
  func login(email: String, password: String, completionHandler: @escaping (Result<ReceivedUserData, NetworkServiceError>) -> Void) {
    let dataToSend = UserDataToSend(email: email, password: password)
    let url = urlProvider.makeURL(with: URLFactory.Auth.login)
    execute(url: url, method: .post, parameters: dataToSend, requestType: .authorization) { result in
      completionHandler(result)
    }
  }
  
  // MARK: - Common
  private func execute<Response: Decodable>(url: String,
                                            method: HTTPMethod,
                                            headers: [String: String] = [:],
                                            requestType: RequestType = .common,
                                            completionHandler: @escaping (Result<Response, NetworkServiceError>) -> Void) {
    guard let url = URL(string: url) else {
      completionHandler(.failure(.invalidURL))
      return
    }
    AF.request(url, method: method, headers: modifiedHeaders(from: headers, requestType: requestType)).response { response in
      self.handleResponse(response) { result in
        completionHandler(result)
      }
    }
  }
  
  private func execute <Request: Encodable,
                        Response: Decodable> (url: String,
                                              method: HTTPMethod,
                                              parameters: Request,
                                              encoder: ParameterEncoder = JSONParameterEncoder.default,
                                              headers: [String: String] = [:],
                                              requestType: RequestType = .common,
                                              completionHandler: @escaping (Result<Response, NetworkServiceError>) -> Void) {
    guard let url = URL(string: url) else {
      completionHandler(.failure(.invalidURL))
      return
    }
    AF.request(url, method: method,
               parameters: parameters,
               encoder: encoder,
               headers: modifiedHeaders(from: headers, requestType: requestType)).response { response in
      self.handleResponse(response) { result in
        completionHandler(result)
      }
    }
  }
  
  private func handleResponse<Response: Decodable>(_ response: AFDataResponse<Data?>,
                                                   completionHandler: @escaping (Result<Response, NetworkServiceError>) -> Void) {
    switch response.result {
    case .success(let data):
      do {
        guard let data = data else {
          completionHandler(.failure(.noDataReceived))
          return
        }
        let decodedData = try decoder.decode(Response.self, from: data)
        completionHandler(.success(decodedData))
      } catch let error {
        log?.debug(error)
        completionHandler(.failure(.failedToDecode))
      }
    case .failure(let error):
      log?.debug(error)
      completionHandler(.failure(.unknown))
    }
  }
  
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

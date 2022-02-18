//
//  NetworkService.swift
//  Meditation
//

import Foundation
import Alamofire

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
  private let session: Session
  private let logger = RequestLogger()
  
  // MARK: - Init
  init(urlProvider: URLProvider = URLProvider(),
       decoder: JSONDecoder = JSONDecoder(),
       session: Session = Session()) {
    self.urlProvider = urlProvider
    self.decoder = decoder
    self.session = session
  }
  
  // MARK: - Request
  @MainActor func execute<Response: Decodable>(url: String,
                                               method: HTTPMethod,
                                               headers: [String: String] = [:],
                                               requestType: RequestType = .common) async throws -> Response {
    guard let url = URL(string: url) else {
      throw NetworkServiceError.invalidURL
    }
    let request = session.request(url, method: method,
                                  headers: modifiedHeaders(from: headers, requestType: requestType))
      .validate(statusCode: 200..<250)
    let data = try await request.data(logger: logger)
    let result: Response = try await convertData(data)
    return result
  }
  
  @MainActor func execute <Request: Encodable,
                           Response: Decodable> (url: String,
                                                 method: HTTPMethod,
                                                 parameters: Request,
                                                 encoder: ParameterEncoder = JSONParameterEncoder.default,
                                                 headers: [String: String] = [:],
                                                 requestType: RequestType = .common) async throws -> Response {
    guard let url = URL(string: url) else {
      throw NetworkServiceError.invalidURL
    }
    let request = session.request(url, method: method,
                                  parameters: parameters,
                                  encoder: encoder,
                                  headers: modifiedHeaders(from: headers, requestType: requestType))
      .validate(statusCode: 200..<250)
    let data = try await request.data(logger: logger)
    let result: Response = try await convertData(data)
    return result
  }
  
  private func convertData<Response: Decodable>(_ data: Data) async throws -> Response {
    do {
      let decodedData = try decoder.decode(Response.self, from: data)
      return decodedData
    } catch let error {
      log?.error(error)
      throw NetworkServiceError.failedToDecode
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

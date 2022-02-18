//
//  NetworkService+Auth.swift
//  Meditation
//

import Foundation

extension NetworkService: AuthNetworkProtocol {
  func login(email: String, password: String) async throws -> ReceivedUserData {
    let dataToSend = UserDataToSend(email: email, password: password)
    let url = urlProvider.makeURL(with: URLFactory.Auth.login)
    return try await execute(url: url, method: .post, parameters: dataToSend, requestType: .authorization)
  }
  
}

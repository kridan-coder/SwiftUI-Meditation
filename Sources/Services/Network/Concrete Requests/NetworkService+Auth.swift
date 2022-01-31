//
//  NetworkService+Auth.swift
//  Meditation
//
//  Created by Daniel Krivelev on 31.01.2022.
//

import Foundation
import PromiseKit

extension NetworkService: AuthNetworkProtocol {
  func login(email: String, password: String) -> Promise<ReceivedUserData> {
    let dataToSend = UserDataToSend(email: email, password: password)
    let url = urlProvider.makeURL(with: URLFactory.Auth.login)
    return execute(url: url, method: .post, parameters: dataToSend, requestType: .authorization)
  }
  
}

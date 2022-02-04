//
//  DataRequest.swift
//  Meditation
//

import Foundation
import Alamofire
import PromiseKit

extension DataRequest {
  func responseDataAsPromise() -> Promise<AFDataResponse<Data>> {
    return Promise { seal in
      responseData { response in
        seal.fulfill(response)
      }
    }
  }
}

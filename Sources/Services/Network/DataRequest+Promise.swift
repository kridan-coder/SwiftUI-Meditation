//
//  DataRequest.swift
//  Meditation
//
//  Created by Daniel Krivelev on 31.01.2022.
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

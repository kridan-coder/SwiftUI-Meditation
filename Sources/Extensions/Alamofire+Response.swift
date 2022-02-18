//
//  Alamofire+Response.swift
//  Meditation
//

import Foundation
import Alamofire

 // MARK: - RequestError

 struct RequestError: Error, LocalizedError {
   let alamofireError: AFError
   let responseHTTPStatusCode: Int?

   var errorDescription: String? {
     alamofireError.errorDescription
   }
 }

 // MARK: - Response

 extension DataRequest {
   func data(logger: RequestLogger) async throws -> Data {
     let serializer = DataResponseSerializer(emptyRequestMethods: [.post, .patch, .delete, .head])
     let task = serializingResponse(using: serializer)
     let response = await task.response

     var multipartData: Data?
     if case .data(let data) = (self as? UploadRequest)?.uploadable {
       multipartData = data
     }
     logger.logRequest(response.request, multipartData: multipartData)
     logger.logDataResponse(response)

     let statusCode = response.response?.statusCode
     switch response.result {
     case .success(let data):
       return data
     case .failure(let error):
       logger.logError(error)
       var requestError: Error = RequestError(alamofireError: error, responseHTTPStatusCode: statusCode)
       if NetworkErrorService.isOfflineError(error) {
         requestError = NetworkErrorService.offlineError
       }
       throw requestError
     }
   }
 }

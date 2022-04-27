//
//  RequestInterceptor.swift
//  Tarat Store
//
//  Created by Khaled Khaldi on 12/02/2022.
//

import Foundation
import Alamofire

/// Alamofire RequestInterceptor
final class RequestInterceptor: Alamofire.RequestInterceptor {

    // let retryLimit = 3
    // let retryDelay: TimeInterval = 3

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        // guard urlRequest.url?.absoluteString.hasPrefix(K.server.url) == true else {
        //     return completion(.success(urlRequest))
        // }
        // var urlRequest = urlRequest
        // urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        // urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        // urlRequest.addValue(APIConstants.Server.authorizationHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        // /// Set the Authorization header value using the access token.
        // if let token = Settings.shared.accessToken {
        //     urlRequest.addValue(token, forHTTPHeaderField: HTTPHeaderField.token.rawValue)
        // }

        completion(.success(urlRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
         let response = request.task?.response as? HTTPURLResponse
        
        // if let statusCode = response?.statusCode,
        //       (500...599).contains(statusCode),
        //       request.retryCount < retryLimit {
        //         completion(.retryWithDelay(retryDelay))
        //     }

        return completion(.doNotRetryWithError(error))

    }
    
}

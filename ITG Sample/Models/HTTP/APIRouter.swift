//
//  APIRouter.swift
//  Tarat Store
//
//  Created by Khaled Khaldi on 12/02/2022.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case users(since: Int)
    case user(username: String)

    private var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .users:
            return "/users"
        case .user(let username):
            return "/users/\(username)"
        }
    
    }
    
    private var parameters: Data? {
         switch self {
         default:
            return nil
         }
    }
    
    
    private var urlParameters: [URLQueryItem]? {
        switch self {
        case .users(let since):
            return [URLQueryItem(name: "since", value: String(since))]

        default:
            return nil
        }
    }

    func asURLRequest() throws -> URLRequest {
        /// URL
        let baseUrl = K.server.url
        let url = try baseUrl.asURL()

        var urlComponents = URLComponents(url: url.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        
        if let urlParameters = urlParameters {
            urlComponents?.queryItems = urlParameters
        }

        var urlRequest = URLRequest(url: urlComponents!.url!)

        /// Headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        /// Method
        urlRequest.httpMethod = method.rawValue
        
        if let parameters = parameters {
            urlRequest.httpBody = parameters
            //po (String(data: parameters, encoding: String.Encoding.utf8) as String!)
        }
        
        return urlRequest
    }
    
}

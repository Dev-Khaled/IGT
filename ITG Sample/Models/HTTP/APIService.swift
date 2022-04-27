//
//  APIClient.swift
//  Tarat Store
//
//  Created by Khaled Khaldi on 12/02/2022.
//

import Foundation
import Alamofire

/// API implementation of ServiceProtocol
class APIService {
    static let shared: ServiceProtocol = APIService()
    private init() { }
}

extension APIService: ServiceProtocol {
    static let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        let logger = NetworkLogger()
        let interceptor = RequestInterceptor()
        let session = Session(
            configuration: configuration,
            interceptor: interceptor,
            eventMonitors: [logger]
        )
        return session
    }()

    
    /// Fetch item from Server of type
    func fetch<ModelType: Decodable>(
        route: APIRouter,
        completion: @escaping (Result<ModelType, Error>) -> Void
    ) {

        //let request =
        APIService.session.request(route)
            // .cacheResponse(using: route.cache)
            .responseDecodable(of: ModelType.self, decoder: newJSONDecoder()) { response in
                switch response.result {
                case .success(let dataWrapper):
                    completion(.success(dataWrapper))
                case .failure(let error):
                    #if DEBUG
                    print(error)
                    #endif
                    let networkError = response.data.flatMap {
                        try? newJSONDecoder().decode(NetworkError.self, from: $0)
                    }
                    let apiError = APIError.afError(
                        error,
                        message: networkError?.message
                    )
                    completion(.failure(apiError))
                }
            }

    }
    
}

struct NetworkError: Decodable {
    let message: String?
}

enum APIError: Error {
    case custom(String?)
    case afError(AFError, message: String?)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .custom(let string):
            return string
        case .afError(let error, let message):
            return message ?? error.baseUnderlyingError.localizedDescription
        }
    }
}

extension AFError {
    var baseUnderlyingError: Error {
        var error: Error = self
        while let underlyingError = error.asAFError?.underlyingError {
            error = underlyingError
        }
        return error
    }
}



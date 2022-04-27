//
//  MockupService.swift
//  Tarat Store
//
//  Created by Khaled Khaldi on 12/02/2022.
//

import Foundation


/// Mockup implementation of ServiceProtocol
class MockupService {
    static let shared: ServiceProtocol = MockupService()
    private init() { }
}

extension MockupService: ServiceProtocol {
    func fetch<ModelType: Decodable>(route: APIRouter, completion: @escaping (Result<ModelType, Error>) -> Void) {
        let data: ModelType = Bundle.main.load("\(ModelType.self).json")
        completion(.success(data))
    }
}

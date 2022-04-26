//
//  Service.swift
//  Tarat Store
//
//  Created by Khaled Khaldi on 12/02/2022.
//

import Foundation

protocol ServiceProtocol {
    func fetch<ModelType: Decodable>(route: APIRouter, completion: @escaping (Result<ModelType, Error>) -> Void)
}

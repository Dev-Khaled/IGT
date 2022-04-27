//
//  Service.swift
//  Tarat Store
//
//  Created by Khaled Khaldi on 12/02/2022.
//

import Foundation


/// ServiceProtocol for fetching data (API of Mockup)
protocol ServiceProtocol {
    
    /// Fetch item of type
    func fetch<ModelType: Decodable>(route: APIRouter, completion: @escaping (Result<ModelType, Error>) -> Void)
}

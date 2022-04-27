//
//  UserViewModel.swift
//  ITG Sample
//
//  Created by Khaled Khaldi on 27/04/2022.
//

import Foundation
import Interstellar


/// User Details View Model
class UserViewModel: BaseViewModel {
    
    var user: Observable<User> = Observable()

    
    required init() {
        super.init()
    }

    deinit {
        
    }

    
    /// Request User Full Data
    /// - Parameter username: username to fetch
    func requestData(_ username: String) {
        isLoaderHidden.value = .show
        APIService.shared.fetch(route: APIRouter.user(username: username)) { (result: Swift.Result<User, Error>) in
            self.isLoaderHidden.value = .hide
            switch result {
            case .success(let object):
                self.user.update(object)
            case .failure(let error):
                self.alertMessage.update(error.localizedDescription)
            }
        }
    }
    
}

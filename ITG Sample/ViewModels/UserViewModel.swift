//
//  UserViewModel.swift
//  ITG Sample
//
//  Created by Khaled Khaldi on 27/04/2022.
//

import Foundation
import Interstellar

class UserViewModel: BaseViewModel {
    
    var user: Observable<User> = Observable()

    
    required init() {
        super.init()
    }

    deinit {
        
    }

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

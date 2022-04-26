//
//  UserViewModel.swift
//  ITG Sample
//
//  Created by Khaled Khaldi on 27/04/2022.
//

import Foundation
import Interstellar

class UsersViewModel: BaseViewModel {
    
    var items: Observable<[User]> = Observable()

    
    required init() {
        super.init()
    }

    deinit {
        
    }

    func requestData(_ since: Int) {
        isLoaderHidden.value = .show
        APIService.shared.fetch(route: APIRouter.users(since: since)) { (result: Swift.Result<[User], Error>) in
            self.isLoaderHidden.value = .hide
            switch result {
            case .success(let items):
                self.items.update(items)
            case .failure(let error):
                self.alertMessage.update(error.localizedDescription)
            }
        }
    }
    
}

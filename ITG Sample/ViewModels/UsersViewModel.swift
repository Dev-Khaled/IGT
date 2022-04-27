//
//  UserViewModel.swift
//  ITG Sample
//
//  Created by Khaled Khaldi on 27/04/2022.
//

import Foundation
import Interstellar
import CoreData

class UsersViewModel: BaseViewModel {
    
    var items: Observable<[User]> = Observable()
    
    required init() {
        super.init()
        performSelector(
            onMainThread: #selector(fetchCoreData),
            with: nil,
            waitUntilDone: false
        )
    }

    deinit {
        
    }

    var context: NSManagedObjectContext { CDManager.shared.persistentContainer.viewContext }

    @objc func fetchCoreData() {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let fetch = try context.fetch(request)
            self.items.update(fetch)
        } catch {
            print(error)
        }

        requestData(Int(items.value?.last?.id ?? 0))
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

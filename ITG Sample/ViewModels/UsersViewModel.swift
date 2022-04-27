//
//  UserViewModel.swift
//  ITG Sample
//
//  Created by Khaled Khaldi on 27/04/2022.
//

import Foundation
import Interstellar
import CoreData


/// User List View Model
class UsersViewModel: BaseViewModel {
    
    var items: Observable<[User]> = Observable()
    
    public required init() {
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

    
    /// Fetch all stored Users from CD
    @objc func fetchCoreData() {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "id", ascending: true)
        ]
        do {
            let fetch = try context.fetch(request)
            self.items.update(fetch)
        } catch {
            print(error)
        }

        requestData(Int(items.value?.last?.id ?? 0))
    }
    
    
    /// Request new users from GitHub API
    /// - Parameter since: id of last user fetched, or 0 if non
    func requestData(_ since: Int) {
        isLoaderHidden.value = .show
        APIService.shared.fetch(route: APIRouter.users(since: since)) { (result: Swift.Result<[User], Error>) in
            self.isLoaderHidden.value = .hide
            switch result {
            case .success(let items):
                var currentItems = self.items.value ?? []
                currentItems.append(contentsOf: items)
                self.items.update(currentItems)
                #if DEBUG
                CDManager.shared.saveContext()
                #endif
            case .failure(let error):
                self.alertMessage.update(error.localizedDescription)
            }
        }
    }
    
}

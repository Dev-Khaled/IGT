//
//  UserListViewController.swift
//  ITG Sample
//
//  Created by Khaled Khaldi on 26/04/2022.
//

import UIKit

class UserListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

}


extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UserTableCell.self)
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as UserTableCell
        // TODO: cell.configure(...)
        return cell
    }
}


extension UserListViewController: Storyboarded {
    
}

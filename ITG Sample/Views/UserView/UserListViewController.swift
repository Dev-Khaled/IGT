//
//  UserListViewController.swift
//  ITG Sample
//
//  Created by Khaled Khaldi on 26/04/2022.
//

import UIKit

class UserListViewController: BaseWireframe<UsersViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        configure(with: viewModel)

    }

    
    // MARK: - BaseWireframe
    
    override func configure(with viewModel: UsersViewModel) {
        super.configure(with: viewModel)
        
        viewModel.requestData(0)
        viewModel.items.subscribe { [weak self]  items in
            self?.tableView.reloadData()
        }
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
        viewModel.items.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as UserTableCell
        cell.configure(with: viewModel.items.value![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UserDetailsViewController.instantiate()
        controller.user = viewModel.items.value![indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
}


extension UserListViewController: Storyboarded {
    
}

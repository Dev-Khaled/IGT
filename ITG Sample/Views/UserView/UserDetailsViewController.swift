//
//  UserDetailsViewController.swift
//  ITG Sample
//
//  Created by Khaled Khaldi on 26/04/2022.
//

import UIKit
import Kingfisher

class UserDetailsViewController: BaseWireframe<UserViewModel> {

    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var publicReposLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var user: User! {
        didSet {
            setData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        
        configure(with: viewModel)

    }
    
    // MARK: - BaseWireframe
    
    override func configure(with viewModel: UserViewModel) {
        super.configure(with: viewModel)
        
        viewModel.requestData(user.login!)
        viewModel.user.subscribe { [weak self] user in
            self?.user = user
            self?.setData()
        }
    }

    // MARK: - Private
    
    
    /// display user data
    private func setData() {
        guard isViewLoaded, let user = user else { return }
        
        avatarView.kf.setImage(
            with: user.avatarUrl?.url,
            placeholder: UIImage.userPlaceholder
        )
        
        publicReposLabel.text = (user.publicRepos.formattedString).withPlaceholder
        followersLabel.text   = (user.followers.formattedString).withPlaceholder
        followingLabel.text   = (user.following.formattedString).withPlaceholder
        nameLabel.text        = user.name.withPlaceholder

    }
    
}


extension UserDetailsViewController: Storyboarded {
    
}

//
//  UserDetailsViewController.swift
//  ITG Sample
//
//  Created by Khaled Khaldi on 26/04/2022.
//

import UIKit
import Kingfisher

class UserDetailsViewController: UIViewController {

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
    }
    
    
    // MARK: - Private
    
    private func setData() {
        guard isViewLoaded, let user = user else { return }
        
        avatarView.kf.setImage(
            with: user.avatarUrl.url,
            placeholder: UIImage.userPlaceholder
        )
        
        publicReposLabel.text = (user.publicRepos?.formattedString).withPlaceholder
        followersLabel.text   = (user.followers?.formattedString).withPlaceholder
        followingLabel.text   = (user.following?.formattedString).withPlaceholder
        nameLabel.text        = user.name.withPlaceholder

    }
    
    
    
    
}


extension UserDetailsViewController: Storyboarded {
    
}

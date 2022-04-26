//
//  UserTableCell.swift
//  ITG Sample
//
//  Created by Khaled Khaldi on 26/04/2022.
//

import UIKit
import Kingfisher

class UserTableCell: UITableViewCell, NibBased {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with user: User) {
        nameLabel.text = user.login
        switch user.type {
        case .user:
            typeLabel.text = "User".localized
        case .organization:
            typeLabel.text = "Organization".localized
        }
        
        avatarView.kf.setImage(
            with: user.avatarUrl.url,
            placeholder: UIImage.placeholder
        )
    }
    
}

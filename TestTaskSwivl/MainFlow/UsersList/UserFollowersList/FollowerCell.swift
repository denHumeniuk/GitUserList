import UIKit

protocol FollowerCellProtocol: class {
    func configure(with user: Follower)
}

class FollowerCell: UITableViewCell {
    
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userAvatarImageVeiw: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        userAvatarImageVeiw.layer.cornerRadius = imageViewHeightConstraint.constant / 2
        userAvatarImageVeiw.clipsToBounds = true
    }
    
}

extension FollowerCell: FollowerCellProtocol {
    
    func configure(with follower: Follower) {
        self.userNameLabel.text = follower.login
        self.userAvatarImageVeiw.downloadedFrom(link: follower.avatarLink)
    }
    
}


import UIKit

protocol UserCellProtocol: class {
    func configure(with user: User)
}

class GitUserCell: UITableViewCell {
    
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLinkLabel: UILabel!
    @IBOutlet weak var userAvatarImageVeiw: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        userAvatarImageVeiw.layer.cornerRadius = imageViewHeightConstraint.constant / 2
        userAvatarImageVeiw.clipsToBounds = true
    }
    
}

extension GitUserCell: UserCellProtocol {
   
    func configure(with user: User) {
        self.userNameLabel.text = user.login
        self.userAvatarImageVeiw.downloadedFrom(link: user.avatarLink)
        self.userLinkLabel.text = user.userLink
    }
    
}


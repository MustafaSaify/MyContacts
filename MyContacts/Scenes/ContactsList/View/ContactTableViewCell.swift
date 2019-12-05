//
//  ContactTableViewCell.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return "\(self)"
    }
    
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    var imageCancellation: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCancellation?()
        avatarImageView.image = nil
        imageCancellation = nil
    }
    
    func configure(with contact: ContactViewModel) {
        nameLable.text = contact.name
        favoriteImageView.isHidden = !contact.showFavoriteIcon
        
        if let avatarPath = contact.avatarURL {
            self.imageCancellation = contact.imageDownloader?.imageWithURL(avatarPath, completion: { [weak self] (image) in
                self?.avatarImageView.image = image
            })
        }
    }

}

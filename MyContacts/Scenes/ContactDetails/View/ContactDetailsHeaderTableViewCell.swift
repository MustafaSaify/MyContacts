//
//  ContactDetailsHeaderTableViewCell.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/5/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailsHeaderTableViewCell : UITableViewCell {
    
    static var reuseIdentifier: String {
        return "\(self)"
    }
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    private var imageDownloadCancellation: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width/2.0
        avatarImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: ContactHeaderInfoViewModel) {
        nameLabel.text = viewModel.name
        favoriteImageView.image = viewModel.favoriteIcon
        if let avatarUrl = viewModel.avatarUrl {
            imageDownloadCancellation = viewModel.imageDownloader?.imageWithURL(avatarUrl, completion: { [weak self] (image) in
                self?.avatarImageView.image = image ?? UIImage(named: "placeholder_photo")
            })
        }
    }
    
    deinit {
        imageDownloadCancellation?()
    }
    
}

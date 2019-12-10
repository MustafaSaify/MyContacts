//
//  ContactViewModel.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct ContactViewModel {
    
    var id: Int?
    var name: String
    var avatarURL: URL?
    var showFavoriteIcon: Bool
    var imageDownloader: ImageAccess?
    
    init(with dataModel: Contact, imageDownloader: ImageAccess?) {
        self.id = dataModel.id
        self.name = dataModel.first_name + " " + dataModel.last_name
        self.showFavoriteIcon = dataModel.favorite
        self.imageDownloader = imageDownloader
        
        if let avatarPath = dataModel.profile_pic {
            let host = Enviornment.prod.host.absoluteString
            let avatarPath = host + "/" + avatarPath
            self.avatarURL = URL(string: avatarPath)
        }
    }
}

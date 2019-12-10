//
//  ContactHeaderInfoViewModel.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/4/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

class ContactHeaderInfoViewModel {
    var name: String = ""
    var avatarUrl: URL?
    var isFavorite: Bool = false
    var imageDownloader: ImageAccess?
    var editable: Bool
    
    var favoriteIcon: UIImage {
        return isFavorite ? UIImage(named: "favourite_button_selected")! : UIImage(named: "favourite_button")!
    }
    
    var hideAccessoryOptions: Bool {
        return editable
    }
    
    var hideNameLabel: Bool {
        return editable
    }
    
    var hideAddPhotoButton: Bool {
        return !editable
    }
    
    init(with contact: Contact?, editable: Bool) {
        self.name = (contact?.first_name ?? "") + " " + (contact?.last_name ?? "")
        self.isFavorite = contact?.favorite ?? false
        if let avatarPath = contact?.profile_pic {
            let host = Enviornment.prod.host.absoluteString
            let avatarPath = host + "/" + avatarPath
            self.avatarUrl = URL(string: avatarPath)
        }
        self.imageDownloader = NetworkImageAccess()
        self.editable = editable
    }
}

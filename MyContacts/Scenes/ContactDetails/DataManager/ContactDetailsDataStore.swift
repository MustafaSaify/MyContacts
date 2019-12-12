//
//  ContactDetailsDataStore.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/5/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

enum ContactDetailsSceneMode {
    case add
    case view
}

class ContactDetailsDataStore: ContactDetailsDataStoreProtocol {
    
    var mode: ContactDetailsSceneMode = .add
    
    var routedContact: Contact?
        
    var displayedContactInfo: Contact
    
    init(with contact: Contact?) {
        self.routedContact = contact
        self.displayedContactInfo = contact != nil ? contact! :  Contact()
    }
}

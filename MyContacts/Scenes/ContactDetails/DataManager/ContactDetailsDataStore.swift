//
//  ContactDetailsDataStore.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/5/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

class ContactDetailsDataStore: ContactDetailsDataStoreProtocol {
    var routedContact: Contact? {
        didSet {
            if let contact = routedContact {
                self.displayedContactInfo = contact
            }
        }
    }
    var displayedContactInfo: Contact
    
    init(with contact: Contact?) {
        self.routedContact = contact
        self.displayedContactInfo = contact != nil ? contact! :  Contact()
    }
}

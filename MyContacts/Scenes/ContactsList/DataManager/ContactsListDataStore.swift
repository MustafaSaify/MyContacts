//
//  ContactsListDataStore.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/5/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

class ContactsListDataStore: ContactsListDataStoreProtocol {
    var contacts: [Contact] = []
    
    func contact(with id: Int) -> Contact? {
        return contacts.first { $0.id == id }
    }
}

//
//  ContactDetailsDataSyncer.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/7/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

class ContactDetailsDataSyncer : ContactDetailsDataSyncProtocol {
    
    private var syncronizer: Synchronizer = Synchronizer(cacheTime: 0)
    
    func fetchDetails(for contactId: Int, completion: @escaping (SynchronizerResult<Contact>) -> Void) {
        let fetchContactDetailsResource = FetchContactDetailsResource(baseURL: Enviornment.prod.host, contactId: contactId)
        _ = syncronizer.loadResource(fetchContactDetailsResource, completion: completion)
    }
    
    func post(contact: Contact, completion: @escaping (SynchronizerResult<PostContentResponse>) -> Void) {
        let postContactResource = PostContactResource(baseURL: Enviornment.prod.host, contact: contact)
        _ = syncronizer.loadResource(postContactResource, completion: completion)
    }
    
}

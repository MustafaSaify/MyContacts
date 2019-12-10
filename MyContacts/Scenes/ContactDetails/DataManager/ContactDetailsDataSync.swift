//
//  ContactDetailsDataSync.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/7/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

protocol ContactDetailsDataSyncProtocol {
    func fetchDetails(for contactId: Int, completion: @escaping (SynchronizerResult<Contact>) -> Void)
    func post(contact: Contact, completion: @escaping (SynchronizerResult<PostContentResponse>) -> Void)
}

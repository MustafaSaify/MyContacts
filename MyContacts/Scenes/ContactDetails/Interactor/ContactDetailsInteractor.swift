//
//  ContactDetailsInteractor.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/4/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

class ContactDetailsIntearctor : ContactDetailsInteractorInputProtocol {
    
    var presenter: ContactDetailsInteractorOutputProtocol?
    
    var remoteDatamanager: ContactDetailsRemoteDataManagerInputProtocol?
    
    func fetchDetails(for contactId: Int) {
        remoteDatamanager?.fetchDetails(for: contactId)
    }
    
    func update(contact: Contact) {
        remoteDatamanager?.post(contact: contact)
    }
}

extension ContactDetailsIntearctor : ContactDetailsRemoteDataManagerOutputProtocol {
    
    func onFetchingContactDetails(contact: Contact) {
        presenter?.didFetchedContactDetails(contact: contact)
    }
    
    func onPostContactSuccess() {
        presenter?.didSubmittedContact()
    }
    
    func onError() {
        presenter?.onError()
    }
}

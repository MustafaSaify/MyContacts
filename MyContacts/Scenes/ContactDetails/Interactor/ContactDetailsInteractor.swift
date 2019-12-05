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
    
    func update(contact: Contact) {
        
    }
}

extension ContactDetailsIntearctor : ContactDetailsRemoteDataManagerOutputProtocol {
    
    func onUpdateContact(_ contact: Contact) {
        presenter?.didUpdatedContact(contact)
    }
    
    func onAddingNewContact(_ contact: Contact) {
        presenter?.didAddedContact(contact)
    }
    
    func onError() {
        presenter?.onError()
    }
    
}

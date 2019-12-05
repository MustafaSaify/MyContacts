//
//  ContactsListInteractor.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

class ContactsListInteractor: ContactsListInteractorInputProtocol {
    
    weak var presenter: ContactsListInteractorOutputProtocol?
    var remoteDatamanager: ContactsListRemoteDataManagerInputProtocol?
    
    func retrieveContactsList() {
        remoteDatamanager?.retrieveContactsList()
    }
        
}

extension ContactsListInteractor: ContactsListRemoteDataManagerOutputProtocol {
    
    func onContactsRetrieved(_ contacts: [Contact]) {
        presenter?.didRetrieveContacts(contacts)
    }
    
    func onError() {
        presenter?.onError()
    }
    
}

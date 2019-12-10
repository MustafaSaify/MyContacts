//
//  ContactDetailsRemoteDataSyncer.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/7/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

class ContactDetailsRemoteDataManager<DataStoreType: ContactDetailsDataSyncProtocol> {
    
    private let dataSource: DataStoreType
    
    var remoteRequestHandler: ContactDetailsRemoteDataManagerOutputProtocol?
    
    init(dataSource: DataStoreType) {
        self.dataSource = dataSource
    }
}

extension ContactDetailsRemoteDataManager : ContactDetailsRemoteDataManagerInputProtocol {
    
    func fetchDetails(for contactId: Int) {
        dataSource.fetchDetails(for: contactId) { [weak self] (result) in
            switch result {
            case .success(let contact):
                self?.remoteRequestHandler?.onFetchingContactDetails(contact: contact)
            case .error, .noData:
                self?.remoteRequestHandler?.onError()
            }
        }
    }
    
    func post(contact: Contact) {
        dataSource.post(contact: contact) { [weak self] (result) in
            switch result {
            case .success, .noData:
                self?.remoteRequestHandler?.onPostContactSuccess()
            case .error:
                self?.remoteRequestHandler?.onError()
            }
        }
    }
}

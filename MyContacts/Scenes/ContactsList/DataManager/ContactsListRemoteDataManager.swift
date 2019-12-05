//
//  ContactsListRemoteDataManager.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

class ContactsListRemoteDataManager<DataStoreType: ContactsListDatasource> where DataStoreType.DataType == Contact {
    
    private let dataSource: DataStoreType
    
    var remoteRequestHandler: ContactsListRemoteDataManagerOutputProtocol?
    
    init(dataSource: DataStoreType) {
        self.dataSource = dataSource
    }
}

extension ContactsListRemoteDataManager : ContactsListRemoteDataManagerInputProtocol {
    
    func retrieveContactsList() {
        dataSource.fetchContacts { [weak self] (result) in
            switch result {
            case .success(let contacts):
                self?.remoteRequestHandler?.onContactsRetrieved(contacts)
            case .noData:
                self?.remoteRequestHandler?.onContactsRetrieved([])
            case .error:
                self?.remoteRequestHandler?.onError()
            }
        }
    }
}

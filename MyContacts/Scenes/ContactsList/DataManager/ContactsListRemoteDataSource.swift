//
//  ContactsListRemoteDataSource.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct ContactsListRemoteDataSource: ContactsListDatasource {
    
    fileprivate let synchronizer: Synchronizer
    fileprivate let baseURL: URL
    
    init(baseURL: URL, cacheTime: TimeInterval = 0) {
        self.baseURL = baseURL
        self.synchronizer = Synchronizer(cacheTime: cacheTime)
    }
    
    func fetchContacts(completion: @escaping (SynchronizerResult<[Contact]>) -> Void) {
        synchronizer.cancelSession()
        let resource = FetchContactsResource(baseURL: baseURL)
        _ = synchronizer.loadResource(resource, completion: completion)
    }
}

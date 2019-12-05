//
//  ContactsListDataSource.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

protocol ContactsListDatasource {
    associatedtype DataType = Contact
    
    func fetchContacts(completion: @escaping (SynchronizerResult<[DataType]>) -> Void)
}

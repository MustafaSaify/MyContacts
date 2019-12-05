//
//  NetworkConstants.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

enum Endpoint {
    case fetchContacts
    case fetchContactDetails
    case addNewContact
    case updateContact
}

enum Enviornment {
    case prod
    
    var host: URL {
        return URL(string: "https://gojek-contacts-app.herokuapp.com")!
    }
}

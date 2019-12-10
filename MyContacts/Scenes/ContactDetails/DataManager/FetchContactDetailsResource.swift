//
//  FetchContactDetailsResource.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/9/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct FetchContactDetailsResource {
    var baseURL: URL
    var contactId: Int
}

extension FetchContactDetailsResource : Resource {
    
    func request() -> URLRequest {
        var req =  URLRequest(baseURL: baseURL,
                              path: "contacts/\(contactId)",
                              parameters: nil)!
        req.httpMethod = "GET"
        return req
    }
    
    var parse: (Data) throws -> Contact {
        
        return { data in
            return  try JSONDecoder()
                .decode(Contact.self, from: data)
        }
    }
}

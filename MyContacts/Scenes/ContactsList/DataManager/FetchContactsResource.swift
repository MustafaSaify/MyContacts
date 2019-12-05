//
//  ContactsResource.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct FetchContactsResource {
    let baseURL: URL
}

private extension FetchContactsResource {
    
    var parameters: [String: AnyObject]? {
        return nil
    }
}

extension FetchContactsResource: Resource {
    
    func request() -> URLRequest {
        return URLRequest(baseURL: baseURL,
                          path: "contacts.json",
                          parameters: parameters)!
    }
    
    var parse: (Data) throws -> [Contact] {
        return { data in
            return try JSONDecoder()
            .decode([Contact].self, from: data)
        }
    }
}

private struct FetchContactsResults: Decodable {
    let results: [Contact]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

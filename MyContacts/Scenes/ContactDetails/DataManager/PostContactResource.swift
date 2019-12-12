//
//  PostContactResource.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/7/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct PostContentResponse : Codable {
    
}

struct PostContactResource {
    
    var baseURL: URL
    var contact: Contact
    
    var isUpdatingExistingContact: Bool {
        return contact.id != nil
    }
}

private extension PostContactResource {
    
    var body: Data? {
        return try? JSONEncoder().encode(contact)
    }
}

extension PostContactResource : Resource {
    
    func request() -> URLRequest {
        var req =  URLRequest(baseURL: baseURL,
                              path: endpoint(),
                              parameters: nil)!
        req.httpBody = body
        req.httpMethod = httpMethod()
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return req
    }
    
    private func endpoint() -> String {
        let path = "contacts"
        let endpoint = isUpdatingExistingContact ? "\(path)/\(contact.id!)" : path
        return endpoint + ".json"
    }
    
    private func httpMethod() -> String {
        return isUpdatingExistingContact ? "PUT" : "POST"
    }
    
    var parse: (Data) throws -> PostContentResponse {
        
        return { data in
            return  try JSONDecoder()
                .decode(PostContentResponse.self, from: data)
        }
    }
}

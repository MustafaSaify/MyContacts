//
//  Contact.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct Contact : Codable {
    var id: Int?
    var first_name: String = ""
    var last_name: String = ""
    var favorite: Bool = false
    var profile_pic: String?
    var email: String?
    var phone_number: String?
}

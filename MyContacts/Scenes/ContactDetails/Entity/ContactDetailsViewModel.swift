//
//  ContactDetailsViewModel.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/4/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

enum ContactDetailsSection : Int {
    case header = 0
    case details = 1
}

enum ContactDetailsFormItem {
    case firstName
    case lastName
    case email
    case phone
    
    var title: String {
        switch self {
        case .firstName:
            return "First Name".localizedCapitalized
        case .lastName:
            return "Last Name".localizedCapitalized
        case .email:
            return "email".localizedLowercase
        case .phone:
            return "mobile".localizedLowercase
        }
    }
}

enum ContactDetailsFormMode {
    case view
    case edit
}

class ContactDetailsViewModel {
    
    class FormItem {
        var type: ContactDetailsFormItem!
        var value: String?
        var isEditable: Bool = false
        
        init(type: ContactDetailsFormItem, value: String?, editable: Bool) {
            self.type = type
            self.value = value
            self.isEditable = editable
        }
    }
    
    var headerInfo: ContactHeaderInfoViewModel!
    var formItems: [FormItem] = []
    var mode: ContactDetailsFormMode = .view
    
    init(with contact: Contact, mode: ContactDetailsFormMode = .view) {
        self.headerInfo = ContactHeaderInfoViewModel(with: contact)
        self.formItems = formItems(for: mode, contact: contact)
    }
    
    private func formItems(for mode: ContactDetailsFormMode, contact: Contact) -> [FormItem] {
        //var formItems = [FormItem]()
        let email = FormItem(type: .email, value: contact.email, editable: mode != .view)
        let phone = FormItem(type: .phone, value: contact.phone_number, editable: mode != .view)
        return [email, phone]
    }
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard let _section = ContactDetailsSection(rawValue: section) else {
            return 0
        }
        switch _section {
        case .header:
            return 1
        case .details:
            return formItems.count
        }
    }
}

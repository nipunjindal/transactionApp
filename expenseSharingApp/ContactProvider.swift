//
//  ContactProvider.swift
//  expenseSharingApp
//
//  Created by njindal on 3/10/18.
//  Copyright © 2018 adobe. All rights reserved.
//

import UIKit
import Contacts

class PhoneContacts {
    
    static public var names: [String] = getContacts()
    
    static func getContacts() -> [String] {
        var allNames = [String]()
        let contactStore = CNContactStore()
        var contacts = [CNContact]()
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
        let request = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            try contactStore.enumerateContacts(with: request) { (contact, stop) in
                contacts.append(contact)
                allNames.append(contact.givenName)
            }
        } catch {
            print(error.localizedDescription)
        }
        return allNames
    }
}


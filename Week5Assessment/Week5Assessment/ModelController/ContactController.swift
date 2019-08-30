//
//  ContactController.swift
//  Week5Assessment
//
//  Created by Blake kvarfordt on 8/30/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    // Database that is used to save CKRecords. I choose to have a private database becasue each user should have his / her own contacts
    let database = CKContainer.default().privateCloudDatabase
    
    // Shared Instance
    static let shared = ContactController()
    
    // Empty array to fill with CKRecords and Contacts
    var contacts = [Contact]()
    
    // Function to make CKRecords out of our contacts, save them to the database, and append the created contact to the emptyArray
    func createAndSave(contact: Contact, completion: @escaping (Bool) -> Void) {
        
        let contact = contact
        
        let contactRecord = CKRecord(contact: contact)
        
        database.save(contactRecord) { (record, error) in
            
            if let error = error {
                print("Error saving record in \(#function) \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let contactRecord = record, let contact = Contact(ckRecord: contactRecord) else {completion(false); return }
            
            self.contacts.append(contact)
            
            completion(true)
            
        }
    }
    
    // Function to query for CKRecords that we want for our app. Retrieve Contact items from the records and set the empty Array as those Contacts
    func queryForRecords(completion: @escaping (Bool) -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: ContactConstants.recordTypKey, predicate: predicate)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print("Error saving record in \(#function) \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let records = records else { completion(false); return }
            
            let contacts = records.compactMap({Contact(ckRecord: $0)})
            
            self.contacts = contacts
            
            completion(true)
        }
    }
    
    func updateRecords(contact: Contact, completion: @escaping (Bool) -> Void) {
        
        let operation = CKModifyRecordsOperation()
        
        operation.recordsToSave = [CKRecord(contact: contact)]
        
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.queuePriority = .high
        operation.completionBlock = {
            completion(true)
            print("Contact was updated")
        }
        
        database.add(operation)
    }
    
    func updateContacts(contact: Contact?, name: String, number: String?, email: String?) {
        guard let contact = contact else { return }
        contact.name = name
        contact.number = number
        contact.email = email
        updateRecords(contact: contact) { (_) in
            print("yessir")
        }
    }
}

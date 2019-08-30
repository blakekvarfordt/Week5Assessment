//
//  ContactTableViewCell.swift
//  Week5Assessment
//
//  Created by Blake kvarfordt on 8/30/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    // Cell outlet properties
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    
    // Comtact property that updates cell labels when a contact is set
    var contact: Contact? {
        didSet {
            
        }
    }
    
    // Update views function that is called when a new contact is created
    func updateViews() {
        
        guard let contact = contact else { return }
        
        contactNameLabel.text = contact.name
        contactNumberLabel.text = contact.number
        contactEmailLabel.text = contact.email
    }

}

//
//  ContactDetailViewController.swift
//  Week5Assessment
//
//  Created by Blake kvarfordt on 8/30/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    // Outlet labels
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    // Contact property that will set when a cell is clicked on. Labels will be updated too.
    var contact: Contact? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func updateViews() {
        
        guard let contact = contact else { return }
        
        nameTextField.text = contact.name
        numberTextField.text = contact.number
        emailTextField.text = contact.email
    }
    
    @IBAction func saveContactButtonTapped(_ sender: Any) {
        
        if let modifiedContact = contact {
            guard let name = nameTextField.text, let number = numberTextField.text, let email = emailTextField.text else { return }
            
                    DispatchQueue.main.async {
                        ContactController.shared.updateContacts(contact: modifiedContact, name: name, number: number, email: email)
                        self.navigationController?.popViewController(animated: true)
                    }
        } else {
            guard let name = nameTextField.text, let number = numberTextField.text, let email = emailTextField.text else { return }
            let newContact = Contact(name: name, number: number, email: email)
            
            ContactController.shared.createAndSave(contact: newContact) { (success) in
                
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        
        
        
        
        
        
        
    }

}

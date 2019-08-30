//
//  ContactTableViewController.swift
//  Week5Assessment
//
//  Created by Blake kvarfordt on 8/30/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    func loadData() {
        
        ContactController.shared.queryForRecords { (success) in
            
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ContactController.shared.contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }

        let contact = ContactController.shared.contacts[indexPath.row]
        
        cell.contact = contact

        return cell
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailVC" {
            
            guard let index = tableView.indexPathForSelectedRow, let destination = segue.destination as? ContactDetailViewController else { return }
            
            let contact = ContactController.shared.contacts[index.row]
            
            destination.contact = contact
        }
    }
    

}

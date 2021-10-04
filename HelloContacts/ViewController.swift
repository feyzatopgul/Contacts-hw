//
//  ViewController.swift
//  HelloContacts
//
//  Created by fyz on 7/6/18.
//  Copyright © 2018 Feyza Topgul. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UITableViewController {
    
    var contactStore = CNContactStore()
    var contacts = [MyContacts] ()
    
    func fetchContacts() {
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: key)
        try! contactStore.enumerateContacts(with: request) { (contact, stoppingPointer) in
            
            let firstName = contact.givenName
            let familyName = contact.familyName
            let phoneNumber =  contact.phoneNumbers.first?.value.stringValue
            let contactToAppend = MyContacts (firstName: firstName, familyName: familyName, phoneNumber:phoneNumber!)
            
            self.contacts.append(contactToAppend)
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactStore.requestAccess(for: .contacts) { (sucess, error) in
            if sucess {
                print("sucessful")
            }
        }
        fetchContacts()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let contactToDisplay = contacts[indexPath.row]
        cell.textLabel?.text = contactToDisplay.firstName + " " + contactToDisplay.familyName
        cell.detailTextLabel?.text =  contactToDisplay.phoneNumber
        return cell
        
    }
    


}


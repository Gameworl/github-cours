//
//  TableContactsViewController.swift
//  appliContact
//
//  Created by local192 on 04/02/2021.
//

import UIKit
import CoreData

class TableContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listeContacts = [Contact]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listeContacts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCellContact = tableView.dequeueReusableCell(withIdentifier: "cellContact", for: indexPath) as! TableViewCellContact
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonActive(_:)), for: .touchUpInside)
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(editButtonActive(_:)), for: .touchUpInside)
        cell.setContact(contact: listeContacts[indexPath.row])
        return cell
    }
    
    // load contacts
    func loadContacts() {
        // methode pour récupérer tous les contact
        let fetchRequest:NSFetchRequest<Contact> = Contact.fetchRequest()
                do {
                    self.listeContacts = try context.fetch(fetchRequest)
                    tableContacts.reloadData()
                }catch{
                    print("Liste Vide !")
                }
    }
    // permet mettre qu'une colonne au tableau
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            loadContacts()
        }
    
    @IBOutlet weak var tableContacts: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // permet de relier le tableView au controller
        self.tableContacts.delegate = self
        self.tableContacts.dataSource = self
    }
    
    
    @objc func deleteButtonActive(_ sender: UIButton) {
        do{
            context.delete(listeContacts[sender.tag])
            try context.save()
        }catch {
            print("erreur de suppression")
        }
        
    loadContacts()
        
    }
    
    @objc func editButtonActive(_ sender: UIButton) {
        performSegue(withIdentifier: "editSegue", sender: listeContacts[sender.tag])
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            if let editView = segue.destination as? EditViewController{
                if let contact = sender as? Contact{
                    editView.editContact = contact
                }
            }
        }
    }

}

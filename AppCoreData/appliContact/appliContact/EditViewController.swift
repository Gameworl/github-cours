//
//  EditViewController.swift
//  appliContact
//
//  Created by local192 on 04/02/2021.
//

import UIKit

class EditViewController: UIViewController {
    var editContact: Contact!
    
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var nom: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let contact = editContact {
            tel.text = contact.tel
            nom.text = contact.nom
        }
    }
    

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
     @IBAction func editButton(_ sender: Any) {
        editContact.nom = nom.text
        editContact.tel = tel.text
        
        ad.saveContext()
        
        nom.text = ""
        tel.text = ""
        dismiss(animated: true, completion: nil)
     }
    

}

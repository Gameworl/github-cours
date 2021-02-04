//
//  ViewController.swift
//  appliContact
//
//  Created by local192 on 04/02/2021.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var nom: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func saveContact(_ sender: Any) {
        let newContact = Contact(context: context)
        newContact.nom = nom.text
        newContact.tel = tel.text
        
        ad.saveContext()
        
        nom.text = ""
        tel.text = ""
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}


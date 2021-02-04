//
//  ViewController.swift
//  AppNoteWithCoreData
//
//  Created by local192 on 05/01/2021.
//  Copyright © 2021 local192. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textNoteTitle: UITextField!
    @IBOutlet weak var textNoteDesc: UITextView!
    
    override func viewDidLoad() {
        
    }
    @IBAction func actionSaveNote(_ sender: Any) {
        // declaration de la nouvelle note
        let newNote = MyNote(context: context)
        
        
        // Dans tous les cas on capture les données
        newNote.title = textNoteTitle.text
        newNote.desc = textNoteDesc.text
        newNote.date_creation = NSDate() as Date
        
        // enregistrer les changements dans la bd
        ad.saveContext()
        textNoteDesc.text = ""
        textNoteTitle.text = ""
    }
    
   
    @IBAction func backToListNote(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


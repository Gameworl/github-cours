//
//  ViewController.swift
//  AppNoteCoreData
//
//  Created by local192 on 06/01/2021.
//

import UIKit

class AddController: UIViewController {

    @IBOutlet weak var textNoteTitle: UITextField!
    @IBOutlet weak var textNoteDesc: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backAddBouton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func actionSaveButton(_ sender: Any) {
        let newNote = MyNote(context: context)
        newNote.title = textNoteTitle.text
        newNote.desc = textNoteDesc.text
        newNote.date_creation = NSDate() as Date
        
        ad.saveContext()
        textNoteDesc.text = ""
        textNoteTitle.text = ""
        dismiss(animated: true, completion: nil)
    }
}


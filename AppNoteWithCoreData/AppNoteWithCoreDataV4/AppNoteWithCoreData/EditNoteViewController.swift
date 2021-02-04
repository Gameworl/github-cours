//
//  EditNoteViewController.swift
//  AppNoteWithCoreData
//
//  Created by local192 on 14/01/2021.
//  Copyright © 2021 local192. All rights reserved.
//

import UIKit

class EditNoteViewController: UIViewController {
    
    
    @IBOutlet weak var editTitleNote: UITextField!
    
    @IBOutlet weak var editDescNote: UITextView!
    
    
    var editNote: MyNote?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("APPNOTEDDD : EditViewController : \(editNote)")
        if let note = editNote {
            editTitleNote.text = note.title
            editDescNote.text = note.desc
        }
    }
    
    @IBAction func editSaveButton(_ sender: Any) {
        
        let newNote = editNote
        
        newNote?.title = editTitleNote.text
        newNote?.desc = editDescNote.text
        newNote?.date_creation = NSDate() as Date
        
        ad.saveContext()
        editTitleNote.text = ""
        editDescNote.text = ""
    }
    
    @IBAction func backToListNotes(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}

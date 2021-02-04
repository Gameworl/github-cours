//
//  EditController.swift
//  AppNoteCoreData
//
//  Created by local192 on 13/01/2021.
//

import UIKit

class EditController: UIViewController {
    
    @IBOutlet weak var textNoteTitle: UITextField!
    @IBOutlet weak var textNoteDesc: UITextView!
    var editNote:MyNote!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let note = editNote{
            textNoteDesc.text = note.desc
            textNoteTitle.text = note.title
        }
    }
    @IBAction func backEditButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func editSaveButton(_ sender: Any) {
        if let note = editNote{
            note.desc = textNoteDesc.text
            note.title = textNoteTitle.text
            note.date_creation = NSDate() as Date
            
            ad.saveContext()
            textNoteDesc.text = ""
            textNoteTitle.text = ""
            dismiss(animated: true, completion: nil)
        }
    }
}

//
//  TableViewCellNotes.swift
//  AppNoteCoreData
//
//  Created by local192 on 13/01/2021.
//

import UIKit

class TableViewCellNotes: UITableViewCell {

    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showDesc: UITextView!
    @IBOutlet weak var showDateCreation: UILabel!
    @IBOutlet weak var buttonDeleteNote: UIButton!
    @IBOutlet weak var buttonEditNote: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setNote(note:MyNote) {
        showTitle.text = note.title
        showDesc.text = note.desc
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        showDateCreation.text = dateFormatter.string(from: note.date_creation!)
        
    }

}

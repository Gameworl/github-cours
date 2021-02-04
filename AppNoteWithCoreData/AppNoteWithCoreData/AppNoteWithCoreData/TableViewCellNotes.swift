//
//  TableViewCellNotes.swift
//  AppNoteWithCoreData
//
//  Created by local192 on 13/01/2021.
//  Copyright © 2021 local192. All rights reserved.
//

import UIKit

class TableViewCellNotes: UITableViewCell {

    
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showDesc: UITextView!
    @IBOutlet weak var showDate: UILabel!
    
    
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
    
    func setNote(note: MyNote){
        showTitle.text = note.title
        showDesc.text = note.desc
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yy HH:mm"
        showDate.text = dateFormatter.string(from: note.date_creation!)
    }

}

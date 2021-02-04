//
//  TableViewCellContact.swift
//  appliContact
//
//  Created by local192 on 04/02/2021.
//

import UIKit

class TableViewCellContact: UITableViewCell {

    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var nom: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setContact(contact: Contact) {
        tel.text = contact.tel
        nom.text = contact.nom
    }
}

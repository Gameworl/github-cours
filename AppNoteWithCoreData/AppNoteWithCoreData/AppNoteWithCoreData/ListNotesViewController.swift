//
//  ListNotesViewController.swift
//  AppNoteWithCoreData
//
//  Created by local192 on 13/01/2021.
//  Copyright © 2021 local192. All rights reserved.
//

import UIKit
import CoreData

class ListNotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listNotes = [MyNote]()
    
    @IBOutlet weak var tableViewListNotes: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("APPNOTEDDD : ListNotesViewController : viewDidLoad")
        loadNotes()
        print("list notes : \n \(listNotes)")
        self.tableViewListNotes.delegate = self
        self.tableViewListNotes.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("APPNOTEDDD : ListNotesViewController : viewWillAppear ")
        loadNotes()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCellNotes = tableView.dequeueReusableCell(withIdentifier: "CellNote", for: indexPath) as! TableViewCellNotes
        cell.setNote(note: listNotes[indexPath.row])
        
        cell.buttonDeleteNote.tag = indexPath.row
        cell.buttonDeleteNote.addTarget(self, action: #selector(buttonDeleteActivate(_:)), for: .touchUpInside)
        
        cell.buttonEditNote.tag = indexPath.row
        cell.buttonEditNote.addTarget(self, action: #selector(buttonEditActivate(_:)), for: .touchUpInside)
        return cell
    }
    
    // Etape DeleteNote
    @objc func buttonDeleteActivate(_ sender: UIButton) {
        print("buttonDeleteActivate index : \(sender.tag)")
        context.delete(listNotes[sender.tag])
        do {
            try context.save()
        }catch let error as NSError {
            print("Problème de suppression de note : \(error)")
        }
        loadNotes()
    }
    //fin DeleteNote
    
    // Etape EditNote
    @objc func buttonEditActivate(_ sender: UIButton){
        print("APPNOTEDDD : buttonEditActivate index : \(sender.tag)")
        performSegue(withIdentifier: "editOrAddSegue", sender: listNotes[sender.tag])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "editOrAddSegue" {
                if let addOrEditVC = segue.destination as? ViewController {
                   if let editNote = sender as? MyNote {
                    print("APPNOTEDDD : prepare : \(editNote)")
                        addOrEditVC.editNote = editNote
                    }
                }
            }
        }
    //fin EditNote
    
    func loadNotes(){
        let fetchRequest: NSFetchRequest<MyNote> = MyNote.fetchRequest()
        do {
            listNotes = try context.fetch(fetchRequest)
            self.tableViewListNotes.reloadData()
        }catch {
            print("Aucune note dans la base de données !!!!")
        }
    }

}

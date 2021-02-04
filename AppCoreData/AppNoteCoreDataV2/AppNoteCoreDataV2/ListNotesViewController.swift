//
//  ListNotesViewController.swift
//  AppNoteCoreData
//
//  Created by local192 on 13/01/2021.
//

import UIKit
import CoreData

class ListNotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewNotes: UITableView!
    
    var listNotes = [MyNote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewNotes.delegate = self
        self.tableViewNotes.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    func loadNotes(){
        let fetchRequest:NSFetchRequest<MyNote> = MyNote.fetchRequest()
        do {
            self.listNotes = try context.fetch(fetchRequest)
            tableViewNotes.reloadData()
        }catch{
            print("Liste Vide !")
        }
    }
    
    @objc func buttonDeleteActivate(_ sender: UIButton) {
        print("\(sender.tag)")
        do{
            context.delete(listNotes[sender.tag])
            try context.save()
            loadNotes()
        }catch let error as NSError{
            print("Probleme delete note: \(error)")
        }
    }
    
    
    @objc func buttonEditActivate(_ sender: UIButton){
        performSegue(withIdentifier: "editSegue", sender: listNotes[sender.tag])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue"{
            if let editView = segue.destination as? EditController {
                if let note = sender as? MyNote{
                    editView.editNote = note
                }
            }
        }
    }
    
}

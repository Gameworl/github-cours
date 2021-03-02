//
//  ViewController.swift
//  CSeventSQLITE
//
//  Created by local192 on 02/03/2021.
//

import UIKit
import SQLite3



class ViewController: UIViewController {
    
    let dbTableName: String = "CSEvent"
    var db: SQLite?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initialisation de la base de donnée
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let dbFileUrl = documentDirectory.appendingPathComponent(dbTableName).appendingPathExtension("sqlite3")
            print(dbFileUrl.path)
            db = SQLite(path: dbFileUrl.absoluteString)
        }catch{
            print(error)
        }
    }
    
    @IBAction func createTable(_ sender: Any) {
        // si la table n'existe pas on la crée
        if db != nil {
                            let dbStatus = db!.createTable( dbTableName, columnsInfo: [
                                "id integer primary key autoincrement",
                                "title text",
                                "desc text",
                                "date_creation date"
                            ])
                            if dbStatus == SQLITE_OK {
                                print("CSEvent Table is created")
                            }else{
                                print("CSEvent Table is NOT created")
                            }
                        }
        
    }
    
    @IBAction func insertEvent(_ sender: Any) {
        
        let alert = UIAlertController(title: "Insert Event", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (tf) in tf.placeholder = "Title" }
        alert.addTextField { (tf) in tf.placeholder = "Descrption" }
        
        let action = UIAlertAction(title: "Save", style: .default) {
            (action) in
            guard let eventTitle = alert.textFields?.first?.text,
                let eventDesc = alert.textFields?.last?.text
                else {return}
        
            if self.db != nil {
                let eventDateCreation = NSDate() as Date
                let dbStatus = self.db!.insert("'\(self.dbTableName)'",
                    rowInfo: ["title":"'\(eventTitle)'",
                        "desc":"'\(eventDesc)'",
                        "date_creation":"'\(eventDateCreation)'"])
                
                if dbStatus == SQLITE_OK {
                    print("A new event is inserted")
                } else {
                    print("Failed : insert event")
                }
            }
        } //fin du callback
        
        alert.addAction(action)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) {_ in
            alert.dismiss(animated: true, completion: nil)
        } //fin du callback
        alert.addAction(actionCancel)
                present(alert, animated: true, completion: nil)
    }
    
    @IBAction func listeEvent(_ sender: Any) {
        let statement = db!.fetch(self.dbTableName, cond: nil, sortBy: nil, offset: nil)
        
        while sqlite3_step(statement) == SQLITE_ROW {
            let eventId = sqlite3_column_int(statement, 0)
            let eventTitle = String(cString: sqlite3_column_text(statement, 1))
            let eventDesc = String(cString: sqlite3_column_text(statement, 2))
            let eventDateCreation = String(cString: sqlite3_column_text(statement, 3))
            
            print("""
            eventId : \(eventId),
            title : \(eventTitle),
            desc: \(eventDesc),
            date: \(eventDateCreation)
            """)
        }
    }
    
    // update date
    @IBAction func updateEvent(_ sender: Any) {
        let alert = UIAlertController(title: "Update Event", message: nil, preferredStyle: .alert)
        let eventDate = NSDate() as Date
        
        alert.addTextField { (tf) in tf.placeholder = "Event Id" }
        alert.addTextField { (tf) in tf.placeholder = "Title" }
        alert.addTextField { (tf) in tf.placeholder = "Desc" }
        
        let action = UIAlertAction(title: "Save", style: .default) {
            (_) in
            guard let eventId = Int((alert.textFields?.first?.text)!),
                  let eventTitle = alert.textFields![1].text,
                let eventDesc = alert.textFields![2].text
            
                else {return}
        
            if self.db != nil {
                let dbStatus = self.db?.update(self.dbTableName,
                    cond: "id = '\(eventId)'",
                    rowInfo: ["title":"'\(eventTitle)'", "desc":"'\(eventDesc)'", "date_creation":"'\(eventDate)'" ])
                    
                if dbStatus == SQLITE_OK {
                    print("A event : \(eventId) is updated")
                } else {
                    print("Failed to update note : \(eventId)")
                }
            }
        } //fin du callback
        alert.addAction(action)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) {_ in
            alert.dismiss(animated: true, completion: nil)
        } //fin du callback
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
    // delete event
    @IBAction func deleteEvent(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete Event", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (tf) in tf.placeholder = "Event Id" }
        let action = UIAlertAction(title: "Save", style: .default) {
            (_) in
            guard let eventId = Int((alert.textFields?.first?.text)!)
            else {return}
        
            if self.db != nil {
                let dbStatus = self.db?.delete(self.dbTableName,
                    cond: "id = '\(eventId)'")
                
                if dbStatus == SQLITE_OK {
                    print("A event : \(eventId) is deleteed")
                } else {
                    print("Failed to delete event : \(eventId)")
                }
            }
        } //fin du callback
        alert.addAction(action)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) {_ in
            alert.dismiss(animated: true, completion: nil)
        } //fin du callback
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func deleteAllEvent(_ sender: Any) {
        let alert = UIAlertController(title: "Delete All Events", message: nil, preferredStyle: .alert)
        
        let actionDelete = UIAlertAction(title: "Delete", style: .destructive) {_ in
            if self.db != nil {
                let dbStatus = self.db?.deleteAll(self.dbTableName)
                
                if dbStatus == SQLITE_OK {
                    print("A all event : is delete ")
                } else {
                    print("Failed to delete all event")
                }
            }
        } //fin du callback
        alert.addAction(actionDelete)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) {_ in
            alert.dismiss(animated: true, completion: nil)
        } //fin du callback
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
}


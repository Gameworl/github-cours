**BITAUD Clémence**
****
**BDios**
****

****
App Note avec CoreData
****

### Créer un nouveau projet 
- AppNoteCoreData

### Objectifs
- US1 : ajouter/mettre à jour/supprimer une note
- US2 : lister les notes

### IHM
- Pour ajouter une nouvelle page : dans + taper view , prendre View Controller et faire glisser dans le storyboard
- Table View pour la liste des notes
- Scene 1 : la saisie d'une nouvelle note 
- Scene 2 : liste des notes

## Persiter les notes dans la bd
0 - Déclarer une instance sur le PersitentManager de CoreData
- Dans AppDelegate.swift
```swift
let ad = UIApplication.shared.delegate as! AppDelegate
let context = ad.persistentContainer.viewContext
```
1 - Créer l'entité MyNote(id,title,desc,date_création)
```swift
@IBAction func actionSaveNote(_ sender: Any) {
        // declaration de la nouvelle note
        let newNote = MyNote(context: context)
        
        // peuplement de la note
        newNote.title = textNoteTitle.text
        newNote.desc = textNoteDesc.text
        newNote.date_creation = NSDate() as Date
        
        // enregistrer les changements dans la bd
        ad.saveContext()
        textNoteDesc.text = ""
        textNoteTitle.text = ""
    }
```
## List
1 - 
2- ListNoteViewController : subclass UIViewController
3 - La scene est relier
4 - Créer navigation
- Faire glisser avec Ctrl le bouton vers le ViewController voulu
choisir show

## Cellules de la table
1 - Créer TableViewCellNotes de type UITableViewCell
- File -> New..-> File -> Cacao..

2 - Relier le cellule de la  scene2 à la classe TableViewCellNotes

3 - Nommer la cellule CellNote

## Chargement des notes dans List Notes
1 - RElier les attributs d'une note de la scene2 vers TableViewCellNote
```swift
@IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showDesc: UITextView!
    @IBOutlet weak var showDate: UILabel!
```
2 - Equiper la classe TableViewCellNote de la fonction setNote(note) qui va remplir les valeurs d'une note dans une cellule du tableau
```swift
func setNote(note: MyNote){
        showTitle.text = note.title
        showDesc.text = note.desc
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yy HH:mm"
        showDate.text = dateFormatter.string(from: note.date_creation!)
    }
```
3 - La classe ListNoteViewController doit charger les données dans le tableau
- Pour cela la classe ListNotesViewController doit implementer les classes : UITableViewDelegate, UITableViewDataSource
- La classe ListNotesViewController doit impléter numberOfSections,..
```swift
var listNotes = [MyNote]()
    
    @IBOutlet weak var tableViewListNotes: UITableView!

        override func viewDidLoad() {
                super.viewDidLoad()
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
        return cell
    }
```
4 - il faut charger les notes 
```swift
func loadNotes(){
        let fetchRequest: NSFetchRequest<MyNote> = MyNote.fetchRequest()
        do {
            listNotes = try context.fetch(fetchRequest)
        }catch {
            print("Aucune note dans la base de données !!!!")
        }
    }
```
Dans le constructeur
```swift    
override func viewDidLoad() {
        super.viewDidLoad()
        loadNotes()
        print("list notes : \n \(listNotes)")
        self.tableViewListNotes.delegate = self
        self.tableViewListNotes.dataSource = self
    }
```
5 - La classe ListNotesViewController doit déclarer une instance sur la tableView(tableViewListNotes)
6 - La ListNotesViewController doit être delegate et le datasource 
```swift
```
7 - On lance l'app et sa marche ,youpi !!!!

## Problème de hierarchie des scenes
1- On supprime le segue retour (secne 2 vers Scene 1)
2- On arrete la secne 2 avec le bar button code pour retrourner à la scene 1
Dans ListNotesViewConytroller
```swift
@IBAction func backToAddNote(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
```

## Version 2
### Delete Note
1 - définir une var de liaison du boutton dans la classe TableViewCellNOtes
```swift
@IBOutlet weak var buttonDeleteNote: UIButton!
```
2 - Dans ListNotesViewController, dans la function cellForRowAt, on : 
 - Tag le button delete
 - definit l'action du addTarget
```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCellNotes = tableView.dequeueReusableCell(withIdentifier: "CellNote", for: indexPath) as! TableViewCellNotes
        cell.setNote(note: listNotes[indexPath.row])
        
        cell.buttonDeleteNote.tag = indexPath.row
        cell.buttonDeleteNote.addTarget(self, action: #selector(buttonDeleteActivate(_:)), for: .touchUpInside)
        return cell
    }

    @objc func buttonDeleteActivate(_ sender: UIButton) {
        print("buttonDeleteActivate index : \(sender.tag)")
    }
```
!!!important!!!

Un objet graphique appartient à la class qui gère la zone dans lequel il se trouve.

App : 
ButtonDelete : TableViewCellNote

3 - Ensuite on delete la note qui dont l'index correspond au tag
```swift
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
```
4 - L'action delete est activé mais la liste des notes n'est pas actualisé. Il faut redémarer l'app pour voir la note à été supprimer de la liste des notes

5 - Problème : l'activation du delete ne recharge pas la liste ou du moins ne passe pas dans le ListNotesViewController:viewDidLoad

6 - Om implémente la fonction ListNotesViewController : viewWillAppear 
```swift
override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ListNotesViewController : viewWillAppear ")
        
    }
```
pour controller le cycle de vie du ViewController mais malheuresement, après activation du boutton delete la liste ne se raffraichie pas et l'appel a ListNotesViewController : viewWillAppear ne se fait non plus

7 - on modifi donc le code de ListNotesViewController : viewWillAppear et ListNotesViewController : loadNotes
```swift
override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("APPNOTEDDD : ListNotesViewController : viewWillAppear ")
        loadNotes()    
}

func loadNotes(){
        let fetchRequest: NSFetchRequest<MyNote> = MyNote.fetchRequest()
        do {
            listNotes = try context.fetch(fetchRequest)
            self.tableViewListNotes.reloadData()
        }catch {
            print("Aucune note dans la base de données !!!!")
        }
}
```
- avec le reloadData sur notre TableView on la previent que les données de la lits ont changé

## Edit Note
# Réarengement de l'application
- Scene 1 : la liste 
    - Pour qu'elle devienne la première scene on lui met dessus la fleche 
- Scene 2 : ajouter une note

1 - définir une var de liaison du boutton dans la classe TableViewCellNOtes
```swift
@IBOutlet weak var buttonEditNote: UIButton!
```
2 - Dans ListNotesViewController, dans la function cellForRowAt, on : 
 - Tag le button delete
 - definit l'action du addTarget
```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCellNotes = tableView.dequeueReusableCell(withIdentifier: "CellNote", for: indexPath) as! TableViewCellNotes
        cell.setNote(note: listNotes[indexPath.row])
        
        cell.buttonDeleteNote.tag = indexPath.row
        cell.buttonDeleteNote.addTarget(self, action: #selector(buttonDeleteActivate(_:)), for: .touchUpInside)
        
        cell.buttonEditNote.tag = indexPath.row
        cell.buttonEditNote.addTarget(self, action: #selector(buttonEditActivate(_:)), for: .touchUpInside)

        return cell
}

@objc func buttonEditActivate(_ sender: UIButton){
    print("buttonEditActivate index : \(sender.tag)")
}
```

3 - Nommer le segue : editOrAddSegue (voir capture d'écran) ; puis aller dans ListNotesViewController : buttonEditActivate
```swift
@objc func buttonEditActivate(_ sender: UIButton){
        print("APPNOTEDDD : buttonEditActivate index : \(sender.tag)")
        performSegue(withIdentifier: "editOrAddSegue", sender: listNotes[sender.tag])
    }
```
On passe dans le sender les infos qu'on veut envoyer a travers le segue

4 - On equipe ViewController pour recevoir la note 
```swift
var editNote: MyNote?
```

5 - Dans ListNotesViewController, on créer une fonction pour envoyer la note
```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editOrAddSegue" {
            if let addOrEditSgueVC = segue.destination as? ViewController {
                if let editNote = sender as? MyNote {
                    addOrEditSgueVC.editNote = editNote
                }
            }
        }
}
```

6 - Adaptation du code du ViewController
```swift
override func viewDidLoad() {
        super.viewDidLoad()
        print("APPNOTEDDD : ViewController : viewDidLoad : \(editNote!)")
        if let note = editNote {
            textNoteTitle.text = note.title
            textNoteDesc.text = note.desc
        }
    }


    @IBAction func actionSaveNote(_ sender: Any) {
        // declaration de la nouvelle note
        let newNote : MyNote?
        
        // affectation de editnote ou initialisation
        if let note = editNote{
            newNote = note
        }else{
            newNote = MyNote(context: context)
        }
        
        // Dans tous les cas on capture les données
        newNote?.title = textNoteTitle.text
        newNote?.desc = textNoteDesc.text
        newNote?.date_creation = NSDate() as Date
        
        // enregistrer les changements dans la bd
        ad.saveContext()
        textNoteDesc.text = ""
        textNoteTitle.text = ""
    }
```

## Version 3
Dans cette version on veut séparer l'edit et le add dans 2 scene différentes
1 - Créer une nouveau Controller : EditNoteViewController
- New File ... subclass : UIViewController
- Dans Main.storyboard : cliquer sur le + et ajouter une ViewController
- Relier le ViewController à notre class EditNoteViewController
- Faire partir le segue du edit de la view et pas du bouton modifier et le nommer "editSegue"

2 - ListNotesViewController
```swift
@objc func buttonEditActivate(_ sender: UIButton){
        print("APPNOTEDDD : buttonEditActivate index : \(sender.tag)")
        performSegue(withIdentifier: "editSegue", sender: listNotes[sender.tag])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "editSegue" {
                if let EditENCV = segue.destination as? EditNoteViewController {
                   if let editNote = sender as? MyNote {
                        print("APPNOTEDDD : prepare : \(editNote)")
                        EditENCV.editNote = editNote
                    }
                }
            }
        }
```

3 - EditNoteViewController
```swift
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
```

4 - ViewController
```swift
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
```

## Version 4 
- Quand on clique sur le + , ça affiche une alerte pour ajouter une note avec titre, descrition et bouton save







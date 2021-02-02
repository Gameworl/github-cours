*****
App note with core data
*****

## Creer un projet
AppCoreData

## IHM de l'app
Deux scenes
- Ajouter/supprimer/modifier note
- lister note 

## Persister les donner de l'app
0- declarer une instance sur le persistance Manager de coreData

1 - creer l'entity mysNote(date_creation, title, desc)

2 - sauvegarder dans la base de  donnée

## List Note
1- La scene list Note est créé

2- ListNoteViewController: creer type UIViewController

3- la scene est relier a son ListNoteViewCobtroller

4- creer la navigation scene1 -> scene2

## Table cell Note
1- créer TableViewCellNotes de type UITableViewCell

2- relier le scellNote de la scene2 a la TableViewCellNote

3- nommer la cellule de la table : CellNote

## Chargement des notes dans list Notes
1- Relier les attributs de d'une note de la scene2 -> TableViewCellNote

2- Equiper la class TableViewCellNote de la fonction setNote(note) qui va remplir les valeurs d'une note dans une cellule du tableau

3- La classe ListNoteViewController doit charger les données dans la list

4- pour cela la classe ListNoteViewController doit implementer les protocoles : UITableViewDelegate et UITableViewDataSource

5 - la classe ListNoteViewController doit implementer :
- numberOfSections
- numberOfRowInSections
- cellForRowAt

6 - La classe ListNoteViewController soit déclarer une instance de TableView

7 - La listeViewController doit etre le delegate et la datasource sur le tableView

8- on lance l'app et on doit voir les notes dans la liste

## Probleme de hierachie des scenes
A cause des 2 segues en mode cycle, la hierarchie des scènes est problematique.
Voir l'outil de debug de hierarchi des scènes.

Pour resoudre de probleme :
1- on supprime le segue retour
2 -on arrete la scene2 avec la bar button back
````swift
    @IBAction func backListNotes(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
````


# Version 2 de l'app
https://developer.apple.com/documentation/swift/using_objective-c_runtime_features_in_swift

## Delete note
-1 on a creer le outlet du bouton dans tableViewCell

-2 on tagger le deleteBouton dans la liste

-3 on a fait le selecteur pour recup le bouton

-4 on a creer la method pour delete la note

-5 Overide de la methode viewWillAppear

-6 appel de loadNote() dans viewWillAppear

## Edit note
tout les objects graphique se trouvant dans une zone doit ce trouver dans son viewController

-1 on a creer le outlet du bouton dans tableViewCell

-2 on tagger le editBouton dans la liste

-4 on a creer la method pour edit la note

-5 l'action sur le bouton edit doit prendre le lien entre la scene de listNote vers la scene addNote. Autrement dit on doit executer le segue.

-6 pour executer le segue, il faut le nommer

-7 on execute le segue et on lui passe la note en cours a éditer
```Swift
 performSegue(withIdentifier: "editOrAddSegue", sender: listNotes[sender.tag])
```
8- la scene Addnote doit capturer la note transporter par le segue
```Swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editOrAddSegue" {
            if let addOrEdit = segue.destination as? ViewController {
                if let note = sender as? MyNote {
                    addOrEdit.editNote = note
                }
            }
        }
    }
```
9- on complete les donnée de la note dans la scene addNote
````Swift
 override func viewDidLoad() {
        super.viewDidLoad()
        print("my edit note : \(editNote!)")
        if let note = editNote {
            textNoteTitle.text = note.title
            textNoteDesc.text = note.desc
        }
        // Do any additional setup after loading the view.
    }
````
10- faire la difference entre le mode add et edit lors de la save 
````Swift
// si editNote alors on est en mode edition
// sinon on est en mode insertion
if let note = editNote {
    newNote = note
}else{
    newNote = MyNote(context: context)
}
````

# Version 3 de l'app
Lorsque nous avons plusieurs segue il faut faire partir du controller et non d'un objet graphique.

1- Quand error sur les selector regarder s'il y a des liasions en jaune 

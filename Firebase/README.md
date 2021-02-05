# Mis en place de firebase

Tout d'abord installer cocoapods et brew

```
//installer brew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

//installer cocoapods
brew install cocoapods
```

## ajout de pod à l'app

Tout d'abord créer une app IOS
Puis à la racine du projet ou se trouve le fichier xcodeproj executer cette commande pour initilaliser le cocoapods :

```
pod init
```
Metter en place l'app ios sur votre firebase (ajoute du fichier GoogleService).
Le fichier PodFile vient d'être créer fermer tout le projet xCode et ouvre le PodFile et mettre ce-ci :

```
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AppTchat' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AppTchat
  # add pods for desired Firebase products
  # https://firebase.google.com/docs/ios/setup#available-pods
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
end
```

Puis installer les dépendance pod :

```
pod install
```

Une fois cela effectuer ouvrer l'application avec le Fichier **xworkspace**

## Dans l'application

dans le AppDeleguate :

```Swift
import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

    ...

}
```
pour se connecter en anonyme, aller dans viewController :
```
import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loginAnonymous()
        // Do any additional setup after loading the view.
    }

    func loginAnonymous(){
        Auth.auth().signInAnonymously(){
            (authResult, error) in
            if let error = error {
                print("Il y a cette erreur :\(error)")
            }else{
                print("Login user UID: \(String(describing: authResult?.user.uid))")
            }
        }
    }
}
```

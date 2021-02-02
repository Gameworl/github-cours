# Protocole

```swift
import UIKit

protocol SomeProtocol{
    //definition
}

// Place du protocol dans l'OOP ou POO
// -1- Swift : heritage : Toute classe ne peut hériter que d'une seul class, héritage simple, autrement dit pas héritage multiple
// - 2 - Swift est obliger d'introduire un mecanisme pour simuler l'héritage multiple
// -3- Si une classe possède une super class et adopte un protocol alors l'ordre de déclaration des héritiers commence d'abord par la super class

class SomeSuperClass {}
class SomeClass: SomeSuperClass, SomeProtocol {}

//property Requirement

protocol SomeProtocol2{
    var pptGettableSettable: Int {
        get set
    }
    var pptgettable : Int {
        get
    }
}

// Exemple
protocol FullyNamed {
    var fullName : String {
        get
    }
}

class Person : FullyNamed {
    var fullName: String
    
    init(fullname: String) {
        self.fullName = fullname
    }
}

let p1 = Person(fullname: "Natan")
print("P1 fullname is \(p1.fullName)")

//Method requirement
protocol operations {
    func add(n1:Int, n2:Int) -> Int
}
class MathOps : operations {
    func add(n1:Int, n2:Int) -> Int {
    return n1 + n2
    }
}

var f1 = MathOps().add(n1: 1, n2: 2)

protocol SomeProtocol3 {
    init(params: Int)
}

class SomeClass3: SomeProtocol3{
    required init(params:Int){
        
    }
}

class SomeSuperClass2{
    init(params: Int){}
}

class SomeClass4: SomeSuperClass2, SomeProtocol3{
    required override init(params: Int){
        super.init(params:params)
    }
}

let someClass4 = SomeClass4(params: 1)


```
# Types  Swift

## 3 familles :


### Named 
- Value
- Primitives
- Structure
- Enum
- ...

### Compound
- Tuple
- Set
- Dict
- Array
- Function
- Closure
- ...

### Reference
- Class
- autre type reference :
  - Objet de la séance du 06/01/2021

## Memory

### Reference
- Class
```swift
  Var car1 = car()
  Var car2 = car1
  ==> car2.color = bluje (affectation sur l'adresse des deux instances)
    -> car1.color === bluje
```
### Value
- Struct 
```swift
  Var car1 = car(), car1.color = bluje
  Var car2 = car1 ==> car2.color === bluje
  ====> car2.color = red
    -> car1 = bluje
```
### Playground 20-Inherence
````Swift
import UIKit

// Inheritance

// Defining a base class
class Vehicule {
    
    var currentSpeed = 0.0
    var decription: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        // do nothing - an arbitary vehicule doesn't necessarily make a noise
    }
    
}

let someVehicule = Vehicule()
print ("Vehicule: \(someVehicule.decription)")

// Subclassing
class Bicycle: Vehicule {
    
    var hasBasket = false

}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print ("Bicycle: \(bicycle.decription)")

// Subclasses can themselves be subclassed
class Tandem: Bicycle {
    
    var currentNumberOfPassagers = 0
    
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassagers = 2
tandem.currentSpeed = 22.0
print ("Tandem: \(tandem.decription)")

// SCREEN Override and Overriding methods

class Train: Vehicule {
    
    override func makeNoise() {
        print ("Choo choo")
    }
    
}

let train = Train()
train.makeNoise()

// Overriding Property Getters and Setters
class Car: Vehicule {
    
    var gear = 1
    
    override var decription: String {
        return super.decription + " in gear \(gear)"
    }
    
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print ("Car: \(car.decription)")

// Overriding Property Observers
class AutomaticCar: Car {
    
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
    
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.decription)")

// Preventing Overrides

// SCREEN PREVENTING OVERRIDES

final class MyFinalClass {
    
    var att:Int = 1
    
}

class NewClass : MyFinalClass {
    
}
````

### Playgrounnd 23-Protocol :
````Swift
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

````

### Playgrounnd 23-Protocol2 :
````Swift
import UIKit

protocol Vehicle : CustomStringConvertible{
    var isRunning : Bool {get set}
    //var description : String {get}
    mutating func start ()
    mutating func turnOff()
}

struct SportsCar: Vehicle{
    
    var description: String {
        if isRunning {
            return "SportsCar is running"
        }else{
            return "SportsCar is stopped"
        }
    }
    
    var isRunning: Bool = false
    
    // var description: String
    
    mutating func start() {
        if isRunning {
            print("Already started")
        }else{
            isRunning = true
            print("Vroooooommmmm")
        }
    }
    
    mutating func turnOff() {
        if isRunning {
            isRunning = false
            print("Crickets")
        }else{
            print("Already stopped")
        }
    }
}

class SemiTruck : Vehicle {
    
     var description: String {
        if isRunning {
            return "SemiTruck is running"
        }else{
            return "SemiTruck is stopped"
        }
    }
    
    var isRunning: Bool = false
    
    // var description: String
    
    func start() {
        if isRunning {
            print("Already started")
        }else{
            isRunning = true
            print("Ruuuummmmmbbbblllllleee")
        }
    }
    
    func turnOff() {
        if isRunning {
            isRunning = false
            print("put ... put ... put")
        }else{
            print("Already stopped")
        }
    }
    
    func blowAirHorn() {
        print("TTTTTTTTOOOOOOOOOOOOTTTTTT")
    }
}

var car1 = SportsCar()
var truck1 = SemiTruck()
car1.start()
car1.turnOff()
truck1.start()
truck1.blowAirHorn()
truck1.turnOff()

var vehicleArray: Array<Vehicle> = [car1, truck1]
for vehicle in vehicleArray {
    print("\(vehicle.description)")
    if let vehicle = vehicle as? SemiTruck {
        vehicle.blowAirHorn()
    }
}

````

### Playgrounnd 23-Protocol3 :

````Swift
import UIKit

protocol Vehicle : CustomStringConvertible{
    var isRunning : Bool {get set}
    var description : String {get}
    var make : String {get set}
    var model : String {get set}
}

extension Vehicle {
    var makeModel:String {
        return "\(make)\(model)"
    }
    mutating func start() {
        if isRunning {
            print("\(self.description) Already started")
        }else{
            isRunning = true
            print("\(self.description) Vroooooommmmm")
        }
    }
    mutating func turnOff() {
        if isRunning {
            isRunning = false
            print("\(self.description) Crickets")
        }else{
            print(" \(self.description) Already stopped")
        }
    }
}

class SportsVehicle : Vehicle{
    var isRunning : Bool = false
    var description : String { return self.makeModel}
    var make : String = ""
    var model : String = ""
    
    init(isRunning: Bool, make:String, model :String) {
        self.isRunning = isRunning;
        self.make = make
        self.model = model
    }
}

class Semitruck : Vehicle{
    var isRunning : Bool = false
    var description : String { return self.makeModel}
    var make : String = ""
    var model : String = ""
    
    init(isRunning: Bool, make:String, model :String) {
        self.isRunning = isRunning;
        self.make = make
        self.model = model
    }
    
    func blowAirHorn() {
        print("TOOOOOOT")
    }
}


var car1 = SportsVehicle(isRunning: false, make: "Modus", model: "21")
var camion = Semitruck(isRunning: false, make: "berlier", model: "XZD")

car1.start()
camion.start()

extension Double{
    var euroString: String {
        return String(format: "€%.02f", self)
    }
    
}

var montant = 989.456
montant.euroString

````
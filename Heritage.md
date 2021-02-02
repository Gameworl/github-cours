# Heritage

```Swift
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

```
# Protocole extension

```swift
import UIKit

protocol Vehicle: CustomStringConvertible {
    var isRunning: Bool { get set }
    var description: String { get set }
    var make: String { get set }
    var model: String { get set }
}

extension Vehicle {
    var makeModel: String {
        return "\(make) \(model)"
    }
    
    mutating func start() {
        if isRunning {
            print ("\(self.description) already started !")
        } else {
            isRunning = true
            print ("\(self.description) fired up")
        }
    }
    
    mutating func turnOff() {
        if isRunning {
            isRunning = false
            print ("\(self.description) shut down !")
        } else {
            print ("\(self.description) already dead")
        }
    }
}

class SportsCar: Vehicle {
    var isRunning: Bool = false
    var make: String
    var model: String
    var description: String {
        return self.makeModel
    }
}

class SemiTruck: Vehicle {
    var isRunning: Bool = false
    var make: String
    var model: String
    var description: String {
        return self.makeModel
    }
    
    init (isRunning: Bool, make: String, model: String) {
        self.isRunning = isRunning
        self.make = make
        self.model = model
    }
    
    func blowAirHorn() {
        print ("TTOOOOOTT")
    }
}

var car1 = SportsCar(isRunning: false, make: "Porsche", model: "911")
var camion1 = SemiTruck(isRunning: false, make: "Berlier", model: "XZD")

car1.start()
camion1.start()

// extension of an existing type
extension Double {
    var euroString: String {
        return String(format: "euros%.02f", self)
    }
}

var montantAchat =  989.9033333
montantAchat.euroString
```
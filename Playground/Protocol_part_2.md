# Protocol part 2

```swift
import UIKit

protocol Vehicle: CustomStringConvertible {
    
    var isRunning: Bool { get set }
//    var description: String { get }
    mutating func start()
    mutating func turnOff()
    
}

struct SportsCar: Vehicle {
    
    var isRunning: Bool = false
    var description: String {
        if isRunning {
            return "SportsCar is running"
        } else {
            return "SportsCar is turned off"
        }
    }
    
    mutating func start() {
        if isRunning {
            print ("Already started !")
        } else {
            isRunning = true
            print ("Vrooooom")
        }
    }
    
    mutating func turnOff() {
        if isRunning {
            isRunning = false
            print ("Crickets")
        } else {
            print ("Already dead")
        }
    }
    
}

class SemiTruck: Vehicle {
    
    var isRunning: Bool = false
     var description: String {
        if isRunning {
            return "SemiTruck is running"
        } else {
            return "SemiTruck is turned off"
        }
    }
    
    func start() {
        if isRunning {
            print ("Already started !")
        } else {
            isRunning = true
            print ("Ruuuumbleeee")
        }
    }
    
    func turnOff() {
        if isRunning {
            isRunning = false
            print ("Put... put....")
        } else {
            print ("Already dead")
        }
    }
    
    func BlowAirHorn() {
        print ("TTOOOOOOOOTT")
    }
    
}

var car1 = SportsCar()
var truck1 = SemiTruck()

car1.start()
truck1.start()
truck1.BlowAirHorn()
//car1.turnOff()
truck1.turnOff()

var vehicleArray: Array<Vehicle> = [car1, truck1]
for vehicle in vehicleArray {
    print ("\(vehicle.description)")
    if let vehicle = vehicle as? SemiTruck {
        vehicle.BlowAirHorn()
    }
}
```
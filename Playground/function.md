# function

```swift
import UIKit

// Learn functions

print ("case 1")

func greet (person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

print (greet(person: "Marie-Lou"))

print ("****************************")

print ("case 2")

func greet2 (_ person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

print (greet2("Marie-Lou"))

print ("****************************")

print ("case 3")

func greet3 (person: String, genre: String) -> String {
    let greeting = "Hello, " + genre + " " + person + "!"
    return greeting
}

print (greet3(person: "Marie-Lou", genre: "Mlle"))

print ("****************************")

print ("case 4")

func greet4 (_ person: String, _ genre: String) -> String {
    let greeting = "Hello, " + genre + " " + person + "!"
    return greeting
}

print (greet4("Marie-Lou", "Mlle"))

print ("****************************")

print ("case 5")

func greet5 (person: String, rank: Int) -> (String, Int) {
    let greeting = "Hello, " + person + " your rank is " + String(rank) + "!"
    return (greeting, rank)
}

print (greet5(person: "Marie-Lou", rank: 3))
```
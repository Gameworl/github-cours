# Overload

```swift
import UIKit

print ("case 1")

func sum (n1: Double, n2: Double) -> Double {
    return n1 + n2
}

print (sum(n1: 1.2, n2: 2.3))

print ("****************")

print ("case 2")

func sum2 (n1: Double, n2: Double, n3: Double) -> Double {
    return n1 + n2 + n3
}

print (sum2(n1: 2.1, n2: 3.5, n3: 4.76))

print ("****************")

print ("case 3")

func sum3 (n1: Double, n2: Double) -> Int {
    return Int(n1 + n2)
}

print (sum3(n1: 1.2, n2: 2.3))

```
# premier pas 

```swift
import UIKit

// Type of variables
var name = "Marie-Lou JACOB"
print (name)

var age:Int = 22
print (age)

var isStudent = true
print (isStudent)

var isTrue:String?
isTrue = "C’est faux"
print ("isTrue : \(isTrue)")

// Let or var
var firstname = "Marie-Lou"
print(firstname)

//lastname = "Jacob"
//print(lastname)

let number = 1234
print(number)

//number+=1
//print(number)

// Convert date
var doubleNumber:Double = 19.9999
var intNumber:Int = 123
var strNumber:String = "90.9999"

var doubleNumber1:Double? = Double(strNumber)
print(doubleNumber1!)

var intNumber1:Int? = Int(strNumber)
//print(intNumber1!)

var strNumber2:String = "111"
var intNumber2:Int? = Int(strNumber2)
print (intNumber2!)

var intNumber3:Int = Int(doubleNumber)
print (intNumber3)

var strBool = "true"
var boolStr = Bool(strBool)
print(boolStr!)

// Math operations and priorities
var n1 = 10
var n2 = 20
var n3 = 5

let sum = n1 + n2
let sub = n1 - n2
let div = n1 / n2
let mul = n1 * n2

/* Priorities
1. ()
2. * ,  /
3. + , -
4. =
*/

let op0 = n1 + n2 * n3
let op1 = n1 - n2 + n3
let op2 = n1 + n2 * n3 + 4

var number1 = 10.1
var number2 = 20.0
var number3 = 30.0
var number4 = 40.0

let op3:Double = (number1 + number2) * number3
let op4 = number1 / number2
let op5 = number1 + number2 * number3 - 4
let op6 = (number1 + number2) * number3 - 4

// String operations
let message = "Bienvenue les men in black"
var fullname = "Marie-Lou Jacob"
let fullMsg = fullname + ", "  + message
print (fullMsg)

let fullMsg2 = "\(fullname), \(message)"
print (fullMsg2)

fullname.append(message)
print(message.capitalized)
message.lowercased()
print (message)
message.uppercased()
print (message)

let info = "Au revoir les men in black"
info.contains("men")
info.contains("Marie-Lou")
let Msg = ""
Msg.isEmpty

// Logic operations
print (3 != 10)
print (3 == 10)
print (3 >= 10)
print (3 > 10)
print (3 < 10)

print (false || false)
print (false || true)
print (true || false)
print (true || true)

let thenumber = 10
print (thenumber > 0 && thenumber < 100)
print (thenumber < 0 && thenumber < 100)

print (thenumber > 0 || thenumber < 100)
print (thenumber < 0 || thenumber < 100)

print (!(3>10))

```
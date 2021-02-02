# Les classes 

```swift
import UIKit

// Lear some class

class Contact {
    
    // Properties
    var name: String? // Peut être optionnel (ajout du ? à la fin de la variable)
    var dateOfBirth: Date? // Peut être optionnelle
    var phoneNumber: String? // Peut être optionnel
    
    // Initializer
    init() {
    }
    
    init (name: String, dateOfBirth: Date, phoneNumber: String) {
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.phoneNumber = phoneNumber
    }
    
    // Methods
    func desc() -> String {
        return ("name: \(self.name!), date: \(self.dateOfBirth!), phoneNumber: \(self.phoneNumber!)")
    }
}

// First use of Contact
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "dd/mm/yyyy"

var contact = Contact(name: "Marie-Lou", dateOfBirth: dateFormatter.date(from: "03/10/1998")!, phoneNumber: "0160704479")

print ("contact: \(contact.desc())" )

print("***********************************")

// Class = REFERENCE
var contact2 = Contact()

// The same reference but 2 different names
contact2 = contact
print ("contact2: \(contact2.desc())" )

contact2.name = "Bibi"
print ("contact2: \(contact2.desc())" )
print ("contact: \(contact.desc())" )

// STRUCTURES
struct ContactS {
    
    // Properties
    var name: String? // Peut être optionnel (ajout du ? à la fin de la variable)
    var dateOfBirth: Date? // Peut être optionnelle
    var phoneNumber: String? // Peut être optionnel
    
    // Initializer
    init() {
    }
    
    init (name: String, dateOfBirth: Date, phoneNumber: String) {
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.phoneNumber = phoneNumber
    }
    
    // Methods
    func desc() -> String {
        return ("name: \(self.name!), date: \(self.dateOfBirth!), phoneNumber: \(self.phoneNumber!)")
    }
}

var contact_s = ContactS(name: "paul", dateOfBirth: dateFormatter.date(from: "03/10/1998")!, phoneNumber: "0160704479")

print ("contact_s: \(contact_s)" )

var contact_s2 = ContactS()
print ("contact_s2: \(contact_s2)" )

contact_s2 = contact_s
print ("contact_s2: \(contact_s2)" )

contact_s2.phoneNumber = "987708"
print ("contact_s2: \(contact_s2)" )
print ("contact_s: \(contact_s)" )

```
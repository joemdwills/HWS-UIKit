import Foundation
import UIKit
// This day is to learn about Protocols and Protocol-oriented programming (POP)
// Protocols: Protocols are a way of describing what properties and methods something must have. You then tell Swift which types use that protocol – a process known as adopting or conforming to a protocol.
protocol Identifiable {
    var id: String {get set}
} /// We can;t create instances of the protocol as it's a description.
struct User: Identifiable {
    var id: String
}
/// Finally we create a function that accepts any Identifiable object.
func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

// PROTOCOL INHERITANCE
protocol Payable {
    func calculateWages() -> Int
}
protocol NeedsTraining {
    func study()
}
protocol HasVacation {
    func takeVacation(days: Int)
}
/// we can now create a single protocol that will inherit all 3 revious protocols instead of having to do them individually. Now we can make new types conform to the single protocol.
protocol Employee: Payable, NeedsTraining, HasVacation {
}

// Extensions allow you to add methods to existing types, to make them do things they weren't originally designed to do.
extension Int {
    func sqaured() -> Int {
        return self*self
    }
}
let number = 8
print(number.sqaured())
/// Swift doesn't let you use stored properties in extensions, only computed ones.

// Protocol extensions are like regular extensions but they extend to the whole protocol so that all conforming types then have thos changes. As an example here is an Array & a Set which both fall under the 'COLLETION' protocol.
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

extension Collection {
    func summarize() {
        print("There are \(count) of us:")
        
        for name in self {
            print(name)
        }
    }
}
pythons.summarize()
beatles.summarize()

// PROTOCOL-ORIENTED PROGRAMMING (POP)
protocol Identifiable2 {
    var id: String { get set }
    func identify()
}

extension Identifiable2 {
    func identify() {
        print("My ID is \(id)")
    }
}
struct User2: Identifiable2 {
    var id: String
}
let twostraws = User2(id: "twostraws")
twostraws.identify()

import Foundation
import UIKit

// Creating Structs; can be given their own vairables, constants & functions then created and used however you want.
struct Sport {
    var name: String
}
var tennis = Sport(name: "Tennis")
print(tennis.name)
// Computed Property; above was an example of a stored property, but structs can run code to figure out it's value.
struct Sport2 {
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic Sport"
        } else {
            return "\(name) is not an Olympic Sport"
        }
    }
}
let chessBoxing = Sport2(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)
// Property Observers let you run code before or after any property changes.
struct Progress {
    var task: String
    var amount: Int {
        didSet { /// HAVE A LOOK AT THE DIFFERENT PROPERTY OBSERVERS AVAILABLE FOR EXAMPLE willSet is an option.
            print("\(task) is now \(amount)% complete")
        }
    }
}
var progress = Progress(task: "Loading Data", amount: 0)
progress.amount = 30
progress.amount = 100

// Stuctures can have functions inside them, they still use the 'func' keyword but are known as METHODS.
struct City {
    var population: Int
    func collectTaxes() -> Int {
        return population * 1000
    }
}
let London = City(population: 9_000_000)
print(London.collectTaxes())

// Mutating Methods, if you create an instance of a struct as a constant, the properties inside can't be changed no matter if they were declared as variables. Swift won't let you write methods that change propeties unless you specifically request it by using the 'mutating' keyword.
struct Person {
    var name: String
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()
print(person.name)

// Strings are actually just Structs! So they have properties that you can use Swift's completions to learn about the Strings.
let string = "Do or do not, there is no try."
print(string.count)
print(string.hasPrefix("Do"))
print(string.uppercased())
print(string.sorted())

// Arrays are also structs, which mean they too have their own methods and properties we cn use to query/manipulate the array.
var toys = ["Woody"]
print(toys.count)
toys.append("Buzz")
toys.firstIndex(of: "Buzz")
print(toys.sorted())
toys.remove(at: 0)

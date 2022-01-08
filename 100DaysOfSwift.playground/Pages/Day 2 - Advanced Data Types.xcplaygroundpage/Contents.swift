import Foundation
import UIKit

// Day 2 (Arrays, Sets, Tuples, Dictionaries, Enumerations)
/// Arrays are built with [] square brackets and begin index with 0.
var names: [String] = ["James","Joe","Pete","Dema","Euan"]

/// Sets are similar to Arrays but have 2 differences: 1. items are stored in a random order, 2. No item can appear twice in a set; all items must be unique.
/// Sets are created with ([]) curly and square brackets
var colours  = Set(["red","blue","green","red","blue"])

/// Tuples; can't be modified after they have been declared (add/remove items), you can't change the type of items in a tuple; but you can access the items in a tuple numerically.
var name = (first: "Taylor", last: "Swift")
name.0

/// Arrays vs Sets vs Tuples
/// If you need a specific, fixed collection of related values where each item has a precise position or name, you should use a TUPLE:
let Address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")

/// If you need a collection of values that must be unique or you need to be able to check whether a specific item is in there extremely quickly, you should use a SET:
let set = Set(["aardvark","astronaut","azalea"])

/// If you need a collection of values that can contain duplicates, or the order of your items matters, you should use an ARRAY:
let snakes = ["Eric", "Graham", "John", "Terry", "Terry", "Michael"]

/// DICTIONARIES are like ARRAYS but use key: value pairs. The Value can be access using the key identifier
var heights = ["Joe": 173, "Jamie": 177]
/// Using annotations then:
var heights2: [String: Int] = ["Mum": 152, "Dad": 175]
heights["Joe"]

/// Set a default return for a dictionary that has a key that doesn't exist.
var favouriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

/// Creating empty collections: ARRAYS, SETS & DICTIONARIES.
var teams = [String: String]() /// Dict
teams["Paul"] = "Red" /// add something to the dictionary

var results = [Int]() /// Empty Array

/// An Empty Set is done slightly differenly
var words = Set<String>()
var numbers = Set<Int>()

/// Enumerations (Enums) are a way of defining groups of related values in a way that makes them easier to use.
enum Result {
    case success
    case failure
}
var response = Result.success

/// Associated Enums provide more data for each case, as an example:
enum Acitivity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

var talking = Acitivity.talking(topic: "football")

/// Enums with raw values provided by Swift
enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

let earth = Planet(rawValue: 2)

var usedNumbers = [Int]()

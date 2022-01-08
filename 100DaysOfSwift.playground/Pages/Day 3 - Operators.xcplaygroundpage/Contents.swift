import Foundation
import UIKit

let firstScore = 12
let secondScore = 4
///Add & subtraction
let total = firstScore + secondScore
let difference = firstScore - secondScore
///Multiply & Divide
let product = firstScore * secondScore
let divided = firstScore / secondScore
/// Remainder
let remainder = 13 % secondScore

//Operator Overloading, means the operator function will change depending on the type of value you use it with.
let meaningOfLife = 42
let doubleMeaning = 42 + 42
///Strings
let fakers = "Fakers gonna "
let action = fakers + "fake"
///Arrays
let firstHalf = ["John", "Paul"]
let seconfHalf = ["George","Ringo"]
let beatles = firstHalf + seconfHalf

// Comparison Operators
let score1 = 6
let score2 = 4
/// == checks two values are the same, != checks two values are not the same
score1 == score2
score1 != score2
/// They even work for Strings which are naturally alphabetical
"Taylor" <= "Swift"

// Conditions: if, else, else if statements
let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 21 {
    print("Blackjack!")
}

// Combining Operators: they are && for "and" and || for "or"
let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 {
    print("Atleast on is over 18")
}

// The Ternary Operator: allows work to be done with 3 values. eg a condition plus a true or false block
let firstnum = 11
let secondnum = 10
/// Below is an example of a Ternary Operator
print(firstnum == secondnum ? "Numbers are the same" : "Numbers are different")

// A Switch Case: is often cleaner than using several if/else if/else conditions.
let weather = "sunny"

switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("wear sunscreen")
    fallthrough /// use this if you want execution to continue on to the next case
default:
    print("Enjoy your day!")
}

// Range Operators: half-open range operator ..< creates ranges up to but excluding the final value, the closed range operator, ... creates a range up to and including the final value
/// for example
let score = 85

switch score {
case 0..<50:
    print("You failed")
case 50..<85:
    print("You did okay")
default:
    print("You did great!")
}

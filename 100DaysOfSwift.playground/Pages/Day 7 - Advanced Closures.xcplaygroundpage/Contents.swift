import Foundation
import UIKit

// Closures with Parameters: closures can accept parameters when passed into a function.
func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}
travel { (place: String) in
    print("I'm going to \(place) in my car")
}
// Closures with return values: replace 'Void' with any type of data to force the closure to return a value.
func travel2(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("Barbados")
    print(description)
    print("I arrived!")
}
travel2 { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
// Shorthand parameter names for closure calls inside functions, Swift knows that only one return has been expressed so that you can remove the return key. Swift also has an ability to use '$' notation followed by a number (beginning with 0) to denote what input it is. Eg:
/// Swift knows the parameter to the closure must be a string because it has been declared so we can remove it:
travel2 { place -> String in
    return "I'm going to \(place) in my car"
}
/// it also knows that the closure must return a String so we can remove that:
travel2 { place in
    return "I'm going to \(place) in my car"
}
/// as the closure only has one line of code that must be the one that returns the value, so Swift lets us remoe the return keyword too:
travel2 {place in
     "I'm going to \(place) in my car"
}
/// let Swift provide automatic names for the closure's parameters. using the dollar sign '$' then a number counting from 0.\
travel2 {
    "I'm going to \($0) in my car"
}

// Closures with multiple parameters
func travel3(action: (String, Int) -> String) {
    print("I'm getting ready to go")
    let description = action("Trinidad", 60)
    print(description)
    print("I arrived!")
}
travel3 {
    "I'm going to \($0) at \($1) miles per hour"
}
// Returning closures from a function, is done by using the '->' specifier twice.
func travel4() -> (String) -> Void {
    return {
        print("I'm goint to \($0)")
    }
}/// we can then call travel to get back the closure like this:
let result = travel4()
result("America")
// Capturing values inside closures, can be useful when trying to count the number of times a closure has been used, eg:
func travel5() -> (String) -> Void {
    var counter = 1
    return {
        print("\(counter). I'm goint to \($0)")
        counter += 1
    }
}
let result2 = travel5()
result2("China")
result2("China")
result2("China")
result2("China")

import Foundation
import UIKit

// Creating Basic Closures; closures are functions that are assigned to a variable.
let driving = {
    print("I'm driving my car")
}
driving()

// Accept parameters in closures by listing them, just after the opening brace. Eg:
let driving2 = { (place: String) in
    print("i'm going to \(place) in my car")
}
driving2("London")
// Closures can also return values, just declare it before the 'in' keyword.
let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
let message = drivingWithReturn("Barbados")
print(message)

// Representing CLOSURES AS PARAMETERS so that closures can be used as parameters for functions requires the '() -> Void' after the type declaration.
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}
travel(action: driving)

// Trailing Closures: if the last paramater of a function is a closure, Swift let's you use a special syntax called trailling closure syntax. To do this you pass it directly after the function inside the braces. eg:
travel() {
    print("I'm driving in my car")
}
// OR
travel {
    print("I'm driving in my car")
}

import Foundation
import UIKit

// Functions are useful becuase they help to reduce duplicate code
func printHelp() {
    let message = """
        Run this app inside a directory of images and
        MyApp will resize them all into thumbnails
        """
    print(message)
}
printHelp()

// Parsing parameters to functions
func square(number: Int) {
    print(number*number)
}
square(number: 7)

/// use a 'return' to send bck that value and stop any future code from running in the function. For example:
func square2(number2: Int) -> Int {
    return number2 * number2
}
let result = square2(number2: 8)
print(result)

// Parameter Labels: Swift allows the ability to provide 2 names for a parameter for better clarification in the funciton. Eg:
func sayHello(to name: String) {
    print("Hello, \(name)!")
}
sayHello(to: "William")
/// Ommit paramter labels using an _, for example.
func sayHello2(_ name: String) {
    print("Hello, \(name)!")
}
sayHello2("Jeremy") /// although this can be useful, it is generally better practice to include parameter labels so that other people understad what's happening.

// Default Parameters:
func greet(_ name: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(name)!")
    } else {
        print("Oh no, it's \(name) again...")
    }
}
greet("Beth", nicely: false)

// Variadic Functions: just mean functions that can take multiple parameters of the same type, like print().
/// This variadic ability is done by using the '...' operator after declaring the type.
func square3(_ numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}
square3(5,6,18,19)

// Writing Errors/Throws for Functions: is useful to have errors for functions a the input to them might be bad. ENUMS must be established for all of the errors that could occur. For example:
enum PasswordError: Error {
    case obvious
}
func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}
/// To RUN throwing functions correctly you must use 3 new keywords, do; to start the execution of code, try; before every function that might throw an error, catch; handle errors gracefully.
do {
    try checkPassword("password66")
    print("This password is good!")
} catch {
    print("You can't use that password")
    }

// INOUT PARAMETERS: are required if you want to change the value of a parameter you are parsing into a functoin. This is done by using the 'inout' keyword before the type declaration, whilst also using the '&' the explicity tell swift you know the variable is inout when the funciton is called.

var myNum = 10
func doubleInPlace(number: inout Int) {
    return number *= 2
}
doubleInPlace(number: &myNum)

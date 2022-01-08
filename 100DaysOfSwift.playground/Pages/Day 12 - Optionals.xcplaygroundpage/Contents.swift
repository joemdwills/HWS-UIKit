import Foundation
import UIKit

// Handling missing data: use a '? = nil' to declare a type as optional.
var age: Int? = nil

// UNWRAPPING OPTIONALS: to use a method on the string you must unwrap the String first.
var name: String? = nil
if let unwrapped = name { /// 'if let' is the powerhouse keyword hear.
    print("\(unwrapped.count) letters")
} else {
        print("Missing name")
}
// Unwarpping with guard: An alternative to 'if let' is 'guard let' which will want to exit the loop/function if it notices a nil inside the optional. A bonus to using 'guard let', is that the optional is safe to use once unwrapped (even if it contains nil).
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't find a name")
        return
    }
    print("Hello, \(unwrapped)!")
}

// FORCE UNWRAPPING: if you know for sure that ou have data present, Swift can allow you to force open the optional and convert it to a non-optional type. Eg:
let str = "5"
let num = Int(str)! /// the '!' is your way of telling Swift to Force unwrap the data type. If not used correctly in an crash your software, so use only when you know the data is correct to be converted.

// IMPLICITLY UNWRAPPED: optionals are already unwrapped when declared, by using the '!' after the type annotation. For example:
let age2: Int! = nil // Because they behave as if they have already been unwrapped you don't need to use 'if let or guard let', however, if they contain nil then your doce will crash.

// NIL-COALESCING: '??' operator at the end of a function call to provide a default value.
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}
let user = username(for: 15) ?? "Anonymous"

// OPTIONAL CHAINING: Swift provides us with a shortcut when using optionals: if you want to access something like a.b.c and b is optional, you can write a question mark after it to enable optional chaining: a.b?.c.
let names = ["John", "Paul", "George", "Ringo"]
let beatle = names.first?.uppercased() // if the optional 'first?' returns nil then the rest of the chain will be ignored. But because there is data the chain progresses.

// OPTIONAL TRY: The first is 'try?', and changes throwing functions into functions that return an optional. If the function throws an error you’ll be sent nil as the result, otherwise you’ll get the return value wrapped as an optional. The other is 'try!' which will force unwrap & crash if it returns nil.
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}
if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}
try! checkPassword("sekrit")
print("OK!")

// FAILABLE INITIALIZER: an initializer that might work or might not. You can write these in your own structs and classes by using 'init?()' rather than init(), and return nil if something goes wrong. The return value will then be an optional of your type, for you to unwrap however you want
struct Person {
    var id: String
    
    init? (id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

// TYPECASTING: Swift must always know the type of each of your variables, but sometimes you know more information than Swift does. For example, here are three classes:
class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}
let pets = [Fish(), Dog(), Fish(), Dog()]
// Swift can see both Fish and Dog inherit from the Animal class, so it uses type inference to make pets an array of Animal.

// If we want to loop over the pets array and ask all the dogs to bark, we need to perform a typecast: Swift will check to see whether each pet is a Dog object, and if it is we can then call makeNoise().

// This uses a new keyword called 'as?', which returns an optional: it will be nil if the typecast failed, or a converted type otherwise.

//Here’s how we write the loop in Swift:
for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}

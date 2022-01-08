import Foundation
import UIKit

// Classes seem very similar to structs but they introduce an important/ complex feature called inheritance, the ability to make one class build on the foundations of another.
// How to create a CLASS, use the keyword 'class'. The first difference between classes & structs, classes never come with a memberwise initializer, so you mist declare them.
class Dog {
    var name: String
    var breed: String
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
let poppy = Dog(name: "Poppy", breed: "Poodle")
// The second difference is that you can create a class based on an existing class - it inherits all the properties and method of the original class. 'CLASS INHERITANCE'. To do tha we do this:
class Poodle: Dog {
    init(name: String) { /// we can make the child class call the parent/super initializer using the syntax below:
        super.init(name: name, breed: "Poodle")
    }
}

// Overriding Methods, child classes can replace parent methods with their own implementations. Do this by using the 'override func' keywords.
class Dog2 {
    func makeNoise() {
        print("Woof!")
    }
}
class Poodle2: Dog2 {
    override func makeNoise() {
        print("Yip!")
    }
}
let poppy2 = Poodle2()
poppy2.makeNoise()

// Final Classes: do very much like they say, stop any child classes being made from that class. Using the 'final' keyword.
final class Dog3 {
    var name: String
    var breed: String
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

// Copying Objects, is the 3rd difference bewtween classes & structs. When a struct is copied the original and copy are different things. When you copy a class, both the original and the copy point to the same thing, so changing one does change the other.
class Singer {
    var name = "Taylor Swift"
}
var singer = Singer()
print(singer.name)
var singerCopy = singer
singerCopy.name = "Justin Bieber"
print(singer.name)

// DEINITIALIZERS, is the 4th difference between structs & classes. Classes have them (a portion of code that runs) when tht instance of a class is destroyed. Use the keyword 'deinit'.
class Person {
    var name = "John Doe"
    init() {
        print("\(name) is alive!")
    }
    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    deinit {
        print("\(name) is no more")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting
}

// MUTABILITY: is the final difference. If you have a constant struct with a variable property, that property can't be changed! However, if you have a constant class with a variable properties, that property can be changed. If you won't want the property to be changed in a class, you must declare it as a constant.
class Singer2 {
    let name = "Taylor Swift"
}
let taylor = Singer2()
print(taylor.name)

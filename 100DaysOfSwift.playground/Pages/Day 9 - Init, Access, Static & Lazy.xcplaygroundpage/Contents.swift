import Foundation
import UIKit

// Initializers are special methods that provide different ways to create your struct.
struct User {
    var username: String
}
var user = User(username: "twostraws")
/// we can provide our own initializer to replace the deafult one, by using the 'init()' keyword
struct User2 {
    var username: String
    
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}
var user2 = User2()

// Referring to the current instance of the Struct Property using the constant 'self'.
struct Person {
    var name: String
    
    init (name: String) {
        print("\(name) was born!") /// name here refers to the input paramter
        self.name = name /// 'self.name' refers to the name property declared on line 22.
    }
}

// Lazy Properties: for performance optimization, Swift lets you create some properties only when they are needed.
struct FamilyTree {
    init() {
            print("Creating family tree!")
    }
}
/// we might use that FamilyTree struct as a property inside a Person struct like this:
struct Person2 {
    var name: String
    lazy var familytree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}
var ed = Person2(name: "Ed")
ed.familytree

// Static Properties & Methods we've created so far have belonged to individual instances of structs, which means that if we had a 'Student' struct we could create several student instances each with their own properties & methods.
struct Student {
    static var classSize = 0 /// You can also let ask Swift to share specific properties and methods across all instances of the struct by declaring them as 'static' using the respective keyword.
    var name: String
    
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}
let jeff = Student(name: "Jeff")
let taylor = Student(name: "Taylor")
/// because 'classSize' property belongs to the struct itself rather than the instances of the struct, we need to read it using Student.classSize, eg:
print(Student.classSize)

// Access Control lets you restrict which code can use properties and methods. This is important because you might want to stop people reading a property directly, for example, a Person Struct which has an 'id' property to store their social security number, Use the 'private' keyword before the variable declaration:
struct Person3 {
    private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    
    func identify() -> String {
        return "My social security number is \(id)"
    }
}
let fred = Person3(id: "12345")

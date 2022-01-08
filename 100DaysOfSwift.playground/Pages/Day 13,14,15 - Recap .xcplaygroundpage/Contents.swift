import Foundation
import UIKit

// Things I want to check.
// - self doesn't always seem to apply to the name

// Arrays, Sets, Tuples & Dictionaries
/// Arrays are built with [] square brackets and begin index with 0.
/// Sets are similar to Arrays but have 2 differences: 1. items are stored in a random order, 2. No item can appear twice in a set; all items must be unique. Sets are created with ([]) curly and square brackets
/// Tuples; can't be modified after they have been declared (add/remove items), you can't change the type of items in a tuple; but you can access the items in a tuple numerically.
/// DICTIONARIES are like ARRAYS but use key: value pairs. The Value can be access using the key identifier

// Loops
/// 'break' is used to exit a loop.
/// 'return' will return a specified value.
/// 'continue' exists the current iteration of a loop and goes straight to the next iteration.

// ENUMS
func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}
// That function accepts a string that defines the current Dweather. The problem is, a string is a poor choice for that kind of data – is it "rain", "rainy" or "raining"? Or perhaps "showering", "drizzly" or "stormy"? Worse, what if one person writes "Rain" with an uppercase R and someone else writes "Ran" because they weren't looking at what they typed?

// Enums solve this problem by letting you define a new data type, then define the possible values it can hold. For example, we might say there are five kinds of weather: sun, cloud, rain, wind and snow. If we make this an enum, it means Swift will accept only those five values – anything else will trigger an error. And behind the scenes enums are usually just simple numbers, which are a lot faster than strings for computers to work with.

// Let's put that into code:

enum WeatherType {
    case sun, cloud, rain, wind, snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    if weather == WeatherType.sun {
        return nil
    } else {
        return "Hate"
    }
}

getHaterStatus(weather: WeatherType.cloud)

// Enums with additional values
enum WeatherType2 {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}
func getHaterStatus2(weather: WeatherType2) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"

    }
}
// Property observers: 'willSet' & 'didSet' use the newValue & oldValue property handles to call them like this:
struct Person {
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }

        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
}
func updateUI(msg: String) {
    print(msg)
}

var taylor = Person(clothes: "T-shirts")
taylor.clothes = "short skirts"

// STATIC PROPERTIES, lets you create properties & methods that belong to a type, rather than to an instance of a type. This is helpful for organising your data meaningfully by storing shared data.
struct TaylorFan {
    static var favoriteSong = "Look What You Made Me Do"

    var name: String
    var age: Int
}

let fan = TaylorFan(name: "James", age: 25)
print(TaylorFan.favoriteSong)
// So, a Taylor Swift fan has a name and age that belongs to them, but they all have the same favorite song. Because static methods belong to the struct itself rather than to instances of that struct, you can't use it to access any non-static properties from the struct.

// ACCESS CONTROL: THE FOUR MODIFIERS ARE:
// Public: this means everyone can read and write the property.
// Internal: this means only your Swift code can read and write the property. If you ship your code as a framework for others to use, they won’t be able to read the property.
// File Private: this means that only Swift code in the same file as the type can read and write the property.
// Private: this is the most restrictive option, and means the property is available only inside methods that belong to the type, or its extensions.

// TYPECASTING, in Swift is the ability to make Swift treat the property of Type A as Type E for example. There are 3 but the most common to are optional downcasting 'as?' or focred downcasting 'as!'.
for album in allAlbums {
    let studioAlbum = album as? StudioAlbum
}

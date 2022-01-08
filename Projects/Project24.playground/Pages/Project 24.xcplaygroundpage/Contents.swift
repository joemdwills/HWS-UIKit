import UIKit
import Foundation
// Part 2.
let name = "Taylor"

for letter in name {
    print("Give me a \(letter)!")
}

let letter = name[name.index(name.startIndex, offsetBy: 3)]

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

let letter2 = name[3]

// using string.isEmpty is far quicker than doing string.count == 0


// Part 3.

let password = "12345"
password.hasPrefix("123")
password.hasSuffix("456")

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}

// to capitalise the first letter

let weather = "it's going to rain"
print(weather.capitalized)

extension String {
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
}


// Contains

let input = "Swift is like Objective-C without the C"
input.contains("Swift")

let languages = ["Python", "Ruby", "Swift"]
languages.contains("Swift")

extension String {
    func containsAny(of array: [String]) -> Bool {
        for item in array {
            if self.contains(item) {
                return true
            }
        }
        return false
    }
}

input.containsAny(of: languages)
// blurred lines between functions/methods & closures BIG TIME
languages.contains(where: input.contains)


// Part 4. Formatting Strings! using NSAttributedString

let string = "This is a test string"

let attribrutes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

let attributedString = NSAttributedString(string: string, attributes: attribrutes)

let attributedString2 = NSMutableAttributedString(string: string)

attributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))

// UILabel, UITextField, UITextView etc all support NSAttributedString you just have to use attributedText instead of text
// Project 24 Challenges
/// Challenge 1
var challenge1 = "pet"
var challenge1b = "carpet"
extension String {
    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) {
            return self
        } else {
        return prefix+self
        }
    }
}

print(challenge1.withPrefix("car"))
print(challenge1b.withPrefix("car"))


/// Challenge 2

let test = "8"
let test2 = "hater"
let test3 = "h8ter"
print(Double(test))
print(Double(test2))
print(Double(test3))

extension String {
    var isNumeric: Bool {
        for letter in self {
            if Double(String(letter)) != nil {
                return true
            }
        }
        return false
    }
}

test.isNumeric
test2.isNumeric
test3.isNumeric

print(test.isNumeric)
print(test2.isNumeric)

/// Challenge 3
let challenge3 = """
    this
    is
    a
    test
    """
let challenge3b = "this\nis\na\ntest"
let challenge3c = "this is a test"

//print(challenge3)
//print(challenge3b.firstIndex(of: "\n"))
//print(challenge3c.firstIndex(of: "\n"))

extension String {
    var lines:  [String] {
        var result: [String] = []
        result = self.components(separatedBy: .newlines)
//        enumerateLines {line, _ in result.append(line)}
        for element in result {
            element.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return result
    }
}


challenge3.lines
challenge3b.lines
challenge3c.lines

import Foundation
import UIKit

var flags = [String]()
var flagCount = [String: Int]()


flags = ["Angola", "Canada", "Djibouti", "Finland", "Japan", "Latvia", "Oman", "Singapore", "UK", "USA", "Vietnam", "Zambia"]
for flag in flags {
    flagCount[flag] = 0
}

print(flagCount)

flagCount["Latvia"]! += 1

print(flagCount)

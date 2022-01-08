import Foundation
import UIKit

// For Loops
let count = 1...10
for number in count {
    print("Number is \(number)")
}
/// the same can be done with arrays
let albums = ["Red", "1989", "Reputation"]
for album in albums {
    print("\(album) is on Apple Music")
}
/// If you don;t use the constant that for loops give you, you should use an underscor instead so that Swift doesn't create needless values, eg:
print("Players gonna ")

for _ in 1...5 {
    print("play")
}

// While Loops; give it a condition to check, and its loop code will go around and around until the condition fails
var number = 1

while number <= 20 {
    print(number)
    number += 1
}
print("Ready or not, here I come!")

// Repeat Loops; are similar to while loops but the condition is at the end, meaning, atleast 1 loop of the code is completed.
var number2 = 1
repeat {
    print(number2)
    number2 += 1
} while number2 <= 20

// Exiting loops using BREAK!
var countDown = 10
while countDown >= 0{
    print(countDown)
    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }
    countDown -= 1
}
print("Blast off!")

// Exiting Multiple Loops; give the first loop a label like "outerloop"
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) is \(product)")
        
        if product == 70 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}

// To Skip items in a loop use "CONTINUE", which will skip the current item and continue to the next one.
for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    print(i)
}

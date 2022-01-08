//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"
var yPosition = [640, 400, 160]
var xPosition = [-100, 1124, -100]

var element = 1

var speed = 200
var pick = Int.random(in: 0...2)
print("Integer: \(pick), Height: \(yPosition[pick]), Start: \(xPosition[pick])")
pick = Int.random(in: 0...2)
print("Integer: \(pick), Height: \(yPosition[pick]), Start: \(xPosition[pick])")
pick = Int.random(in: 0...2)
print("Integer: \(pick), Height: \(yPosition[pick]), Start: \(xPosition[pick])")

if element == 1 {
    speed = -speed
}

print(speed)

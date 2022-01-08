//: [Previous](@previous)

import Foundation
import UIKit

// Challenge 1 an extension on the UIView to animate the scaling down effect of the view using bounceOut(duration: )
extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

let view = UIView()
view.bounceOut(duration: 3)

// Challenge 2 a method that calls a closure as many times as the number is high
extension Int {
    func times(_ closure: () -> Void) {
        guard self > 0 else { return }
        
        for _ in 0..<self {
            closure()
        }
    }
}

6.times() { print("hello world") }


// Challenge 3 a mutating function of Array
extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let location = self.firstIndex(of: item) {
            self.remove(at: location)
        }
    }
}



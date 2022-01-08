//
//  Picture.swift
//  Project1
//
//  Created by Joe Williams on 21/10/2021.
//

import UIKit

class Picture: NSObject, Codable {
    var name: String
    var count: Int
    
    init(name: String, count: Int) {
        self.name = name
        self.count = count
    }
}

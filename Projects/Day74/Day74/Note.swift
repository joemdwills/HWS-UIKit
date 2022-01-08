//
//  Note.swift
//  Day74
//
//  Created by Joe Williams on 02/12/2021.
//

import UIKit

class Note: Codable {
    var title: String
    var text: String
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
    }
}

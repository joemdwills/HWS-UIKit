//
//  Photo.swift
//  Day50
//
//  Created by Joe Williams on 23/10/2021.
//

import UIKit

class Photo: NSObject, Codable {
    var image: String
    var caption: String
    
    init(image: String, caption: String) {
        self.image = image
        self.caption = caption
    }
}

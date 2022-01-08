//
//  Card.swift
//  Day99
//
//  Created by Joe Williams on 30/12/2021.
//

import UIKit

class Card: UIButton {
    var faceDown: Bool
    var backImage: UIImage
    var faceImage: UIImage
    var name: String

    
    init(faceDown: Bool, backImage: UIImage, faceImage: UIImage, name: String, frame: CGRect) {
        self.backImage = backImage
        self.faceImage = faceImage
        self.faceDown = faceDown
        self.name = name
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

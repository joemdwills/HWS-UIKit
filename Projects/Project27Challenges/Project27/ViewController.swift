//
//  ViewController.swift
//  Project27
//
//  Created by Joe Williams on 14/12/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 0
    let startColour = UIColor(red: 208/255, green: 147/255, blue: 13/255, alpha: 1.0)
    let endColour = UIColor(red: 67/255, green: 22/255, blue: 8/255, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        drawEmoji1()
    }

    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        if currentDrawType > 5 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawEmoji1()
        case 1:
            drawTWIN()
        case 2:
            drawEmoji3()
        default:
            break
        }
        
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // awesome drawing code
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        imageView.image = image
    }
    
    func drawEmoji1() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // awesome drawing code
            let head = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            ctx.cgContext.setFillColor(UIColor.systemYellow.cgColor)
//            guard let context = UIGraphicsGetCurrentContext() else { return }
//            let colours = [startColour.cgColor, endColour.cgColor]
//            let colourSpace = CGColorSpaceCreateDeviceRGB()
//            let colourLocations: [CGFloat] = [0.5, 1.0]
//            guard let gradient = CGGradient(colorsSpace: colourSpace, colors: colours as CFArray, locations: colourLocations) else { return }
//            context.cgContext.drawLinearGradient(gradient, start: CGPoint(x: 256, y: 0), end: CGPoint(x: 256, y: 512), options: [])
            ctx.cgContext.setLineWidth(0)
            ctx.cgContext.addEllipse(in: head)
            ctx.cgContext.drawPath(using: .fill)
            
            let eye1 = CGRect(x: 130, y: 120, width: 80, height: 120)
            ctx.cgContext.setFillColor(UIColor.brown.cgColor)
            ctx.cgContext.addEllipse(in: eye1)
            ctx.cgContext.setLineWidth(0)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            
            let eye2 = CGRect(x: 302, y: 120, width: 80, height: 120)
            ctx.cgContext.setFillColor(UIColor.brown.cgColor)
            ctx.cgContext.addEllipse(in: eye2)
            ctx.cgContext.setLineWidth(0)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            let mouth = CGRect(x: 100, y: 300, width: 312, height: 15)
            ctx.cgContext.setFillColor(UIColor.brown.cgColor)
            ctx.cgContext.setLineWidth(0)
            ctx.cgContext.addRect(mouth)
            ctx.cgContext.drawPath(using: .fill)
            
        }
        imageView.image = image
    }
    
    func drawTWIN() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // awesome drawing code
            // start location
            ctx.cgContext.move(to: CGPoint(x: 120, y: 100))
            // T
//            ctx.cgContext.translateBy(x: 0, y: 50)
            ctx.cgContext.addLine(to: CGPoint(x: 220, y: 100))
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.move(to: CGPoint(x: 170, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 170, y: 225))
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            
            
            // W
            ctx.cgContext.move(to: CGPoint(x: 260, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 290, y: 225))
            ctx.cgContext.addLine(to: CGPoint(x: 310, y: 125))
            ctx.cgContext.addLine(to: CGPoint(x: 330, y: 225))
            ctx.cgContext.addLine(to: CGPoint(x: 360, y: 100))
            
            // I
            ctx.cgContext.move(to: CGPoint(x: 380, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 380, y: 225))
            
            // N
            ctx.cgContext.move(to: CGPoint(x: 400, y: 225))
            ctx.cgContext.addLine(to: CGPoint(x: 400, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 480, y: 225))
            ctx.cgContext.addLine(to: CGPoint(x: 480, y: 100))
            
            ctx.cgContext.strokePath()
            
        }
        imageView.image = image
    }
    
    func drawEmoji3() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // awesome drawing code
            ctx.cgContext.translateBy(x: 256, y: 256)
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        imageView.image = image
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // awesome drawing code
            ctx.cgContext.translateBy(x: 256, y: 256)
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        imageView.image = image
    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // awesome drawing code
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 200, y: 150))
        }
        imageView.image = image
    }
}


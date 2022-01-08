//
//  ViewController.swift
//  Day90
//
//  Created by Joe Williams on 20/12/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    var canvasSize: CGSize!
    var picture: UIImage!
    var topString: String!
    var bottomString: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Meme Generator"
        
        let photo = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(selectPhoto))
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareMeme))
        navigationItem.leftBarButtonItem = photo
        navigationItem.rightBarButtonItem = share
        let topText = UIBarButtonItem(title: "Top Text", style: .plain, target: self, action: #selector(writeTopText))
        let bottomText = UIBarButtonItem(title: "Bottom Text", style: .plain, target: self, action: #selector(writeBottomText))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbarItems = [topText, spacer, bottomText]
        navigationController?.isToolbarHidden = false
    }

    @objc func selectPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        picture = image
        imageView.image = image
        dismiss(animated: true)
        canvasSize = image.size
    }
    
    @objc func writeTopText() {
        let ac = UIAlertController(title: "Add Top Text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submit = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            self?.topString = ac?.textFields?[0].text
//            if self?.bottomString == nil {
//                self?.bottomString = ""
//            }
            self?.updateText(topText: self?.topString ?? "", bottomText: self?.bottomString ?? "")
        }
        ac.addAction(submit)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func writeBottomText() {
        let ac = UIAlertController(title: "Add Bottom Text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submit = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            self?.bottomString = ac?.textFields?[0].text
            self?.updateText(topText: self?.topString ?? "", bottomText: self?.bottomString ?? "")
        }
        ac.addAction(submit)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func updateText(topText: String, bottomText: String) {
        let renderer = UIGraphicsImageRenderer(size: self.canvasSize)
        
        let image = renderer.image { ctx in
            // awesome drawing code
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 108),
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.white.cgColor,
                .backgroundColor: UIColor.white.cgColor,
                .strokeColor: UIColor.black.cgColor,
                .strokeWidth: 2
            ]
            self.picture.draw(at: CGPoint(x: 0, y: 0))
            let topLine = NSAttributedString(string: topText, attributes: attrs)
            let topBox = CGRect(x: 0, y: 0, width: self.canvasSize.width, height: 130)
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            ctx.cgContext.addRect(topBox)
            ctx.cgContext.drawPath(using: .fill)
            let bottomLine = NSAttributedString(string: bottomText, attributes: attrs)
            let bottomBox = CGRect(x: 0, y: self.canvasSize.height - 130, width: self.canvasSize.width, height: 130)
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            ctx.cgContext.addRect(bottomBox)
            ctx.cgContext.drawPath(using: .fill)
            topLine.draw(with: topBox, options: .usesLineFragmentOrigin, context: nil)
            bottomLine.draw(with: bottomBox, options: .usesLineFragmentOrigin, context: nil)
        }
        self.imageView.image = image
    }
    
    @objc func shareMeme() {
        
    }

}


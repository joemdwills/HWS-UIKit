//
//  ViewController.swift
//  Day99
//
//  Created by Joe Williams on 30/12/2021.
//

import UIKit

class ViewController: UIViewController {
//    var testButton: UIButton!
    var flags = [String]()
    var flagCount = [String: Int]()
    var faceUpCardNames = [String]()
    var activeCards = [Card]()
    var foundCards = [String]()
    var scoreLabel: UILabel!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var pairLabel: UILabel!
    var card1: Card!
    var card2: Card!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .black
        
        flags = ["Angola", "Canada", "Djibouti", "Finland", "Japan", "Latvia", "Oman", "Singapore", "UK", "USA", "Vietnam", "Zambia"]
        for flag in flags {
            flagCount[flag] = 0
        }
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
//        buttonsView.layer.borderWidth = 1
//        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        buttonsView.layer.cornerRadius = 20
        buttonsView.backgroundColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.5, alpha: 0.52)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.font = UIFont.systemFont(ofSize: 36)
        scoreLabel.textColor = .white
        scoreLabel.textAlignment = .center
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        pairLabel = UILabel()
        pairLabel.translatesAutoresizingMaskIntoConstraints = false
        pairLabel.font = UIFont.systemFont(ofSize: 48)
        pairLabel.textColor = .white
        pairLabel.textAlignment = .center
        pairLabel.text = """
            Last Flag found:
            """
        pairLabel.numberOfLines = 2
        view.addSubview(pairLabel)
        
        
        NSLayoutConstraint.activate([
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            pairLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pairLabel.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -225),
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 750),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        
        let backImage = UIImage(named: "BackCard")
//        let angola = UIImage(named: "Angola")
//        testButton = UIButton(type: .custom)
//        testButton.image
//        testButton.layer.borderWidth = 1
//        testButton.layer.borderColor = UIColor.white.cgColor
//        testButton.backgroundColor = .white
        let cardWidth = 100
        let cardHeight = 160
        
        for row in 0..<4 {
            for col in 0..<6 {
                let flag = loadFlag()
                let frame = CGRect(x: (col * cardWidth) + (col * 24) + 15, y: (row * cardHeight) + (row * 24) + 20, width: cardWidth, height: cardHeight)
                let card = Card(faceDown: true, backImage: UIImage(named: "BackCard")!, faceImage: UIImage(named: flag)!, name: flag, frame: frame)
                card.setImage(backImage, for: .normal)
                card.addTarget(self, action: #selector(cardTapped(_:)), for: .touchUpInside)
                buttonsView.addSubview(card)
            }
        }
        
//        testButton.setImage(angola, for: .selected)
//        testButton.setImage(angola, for: .highlighted)
        
//        testButton.adjustsImageWhenHighlighted = true
    }
    
    func loadFlag() -> String {
        let flag = flagCount.randomElement()!
        let flagKey = flag.key
        if flagCount[flagKey] == 1 {
            flagCount[flagKey]! += 1
            flagCount.removeValue(forKey: flagKey)
        } else if flagCount[flagKey] == 0 {
            flagCount[flagKey]! += 1
        }
        
        return flagKey
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func cardTapped(_ sender: Card) {
        if faceUpCardNames.count == 2 && faceUpCardNames.contains(sender.name) {
            if sender.faceDown {
                return
            } else {
                let index = faceUpCardNames.firstIndex(of: sender.name)
                sender.faceDown.toggle()
                sender.setImage(sender.backImage, for: .normal)
                faceUpCardNames.remove(at: index!)
                activeCards.remove(at: index!)
            }
        } else if faceUpCardNames.count == 2 {
            return
        } else {
            sender.faceDown.toggle()
            if !sender.faceDown {
                sender.setImage(sender.faceImage, for: .normal)
                faceUpCardNames.append(sender.name)
                activeCards.append(sender)
            } else {
                let index = faceUpCardNames.firstIndex(of: sender.name)
                sender.setImage(sender.backImage, for: .normal)
                faceUpCardNames.remove(at: index!)
                activeCards.remove(at: index!)
            }
        }
        
        print("Cards facing up: \(faceUpCardNames.count)")
        print("Facing up cards: \(faceUpCardNames)")
        checkForPairs()
    }
    
    func checkForPairs() {
        if faceUpCardNames.count == 2 {
            let cardA = faceUpCardNames[0]
            let cardB = faceUpCardNames[1]
            if cardA == cardB {
                UIView.animate(withDuration: 1, delay: 0.5, options: []) {
                    self.activeCards[0].alpha = 0
                    self.activeCards[1].alpha = 0
                }
                updateFlagLabel(cardA)
                faceUpCardNames.removeAll()
                activeCards.removeAll()
                foundCards.append(cardA)
                foundCards.append(cardB)
                score += 3
                
            } else {
                card1 = activeCards[0]
                card2 = activeCards[1]
                perform(#selector(flipCards), with: nil, afterDelay: 1)
                card1.faceDown.toggle()
                card2.faceDown.toggle()
                faceUpCardNames.removeAll()
                activeCards.removeAll()
            }
        }
    }
    
    @objc func flipCards() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: card1, duration: 1, options: transitionOptions) {
            self.card1.setImage(self.card1.backImage, for: .normal)
        }
        UIView.transition(with: card2, duration: 1, options: transitionOptions) {
            self.card2.setImage(self.card2.backImage, for: .normal)
        }
    }
    
    func updateFlagLabel(_ flag: String) {
        pairLabel.text = """
            Last Flag found:
            \(flag)
            """
    }
    
    func checkComplete() {
        if foundCards.count == 24 {
            //enter Win Message
        }
    }

}


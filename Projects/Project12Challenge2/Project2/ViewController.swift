//
//  ViewController.swift
//  Project2
//
//  Created by Joe Williams on 13/09/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questions = 0
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(scoreButton))
        
        let defaults = UserDefaults.standard
        if let savedScore = defaults.object(forKey: "highScore") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                highScore = try jsonDecoder.decode(Int.self, from: savedScore)
            } catch {
                print("Failed to load people")
            }
        }
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        navigationItem.title = countries[correctAnswer].uppercased()
        navigationItem.prompt = "High Score: \(highScore), Score: \(score)"
    }
    
    func reset(action: UIAlertAction! = nil) {
        score = 0
        questions = 0
        askQuestion()
    }
        
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        questions += 1
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        let ac2 = UIAlertController(title: title, message: "Your final score is: \(score)", preferredStyle: .alert)
        ac2.addAction(UIAlertAction(title: "Reset", style: .default, handler: reset))
        let ac3 = UIAlertController(title: title, message: "You beat your high score! Your final score is: \(score)", preferredStyle: .alert)
        ac3.addAction(UIAlertAction(title: "Reset", style: .default, handler: reset))
        
        if questions < 10 {
            present(ac, animated: true)
        } else if questions == 10 {
            save()
            if score > highScore {
                present(ac3, animated: true)
            } else {
                present(ac2, animated: true)
            }
        }
    }
    
    @objc func scoreButton() {
        let title = "Score"
        let ac = UIAlertController(title: title, message: "Your current score is: \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(ac, animated: true)
    }
    
    func save() {
        if score > highScore {
            highScore = score
        }
        let jsonEncoder = JSONEncoder()

        if let savedData = try? jsonEncoder.encode(highScore) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "highScore")
        } else {
            print("Failed to save highScore.")
        }
    }
}


//
//  ViewController.swift
//  Project729
//
//  Created by Joe Williams on 12/10/2021.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    
    var guessLabel: UILabel!
    var guessCount: Int = 7 {
        didSet {
            guessLabel.text = "Guesses Remaining: \(guessCount)"
        }
    }
    var scoreLabel: UILabel!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var levelLabel: UILabel!
    var level: Int = 1 {
        didSet {
            levelLabel.text = "Level: \(level)/250"
        }
    }
    var usedLetters = [String]()
    var usedWords = [String]()
    var allWords = [String]()
    var currentWord: UILabel!
    var word = ""
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        currentWord = UILabel()
        currentWord.translatesAutoresizingMaskIntoConstraints = false
        currentWord.font = UIFont.systemFont(ofSize: 34)
        currentWord.text = "?"
        currentWord.numberOfLines = 0
        currentWord.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(currentWord)
        
        let guessButton = UIButton(type: .system)
        guessButton.translatesAutoresizingMaskIntoConstraints = false
        guessButton.setTitle("GUESS", for: .normal)
        guessButton.addTarget(self, action: #selector(guessTapped), for: .touchUpInside)
        view.addSubview(guessButton)
        
        levelLabel = UILabel()
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.font = UIFont.systemFont(ofSize: 20)
        levelLabel.text = "Level: \(level)/250"
        view.addSubview(levelLabel)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.font = UIFont.systemFont(ofSize: 20)
        scoreLabel.text = "Score: \(score)"
        view.addSubview(scoreLabel)
        
        guessLabel = UILabel()
        guessLabel.translatesAutoresizingMaskIntoConstraints = false
        guessLabel.font = UIFont.systemFont(ofSize: 12)
        guessLabel.text = "Guesses Remaining: \(guessCount)"
        view.addSubview(guessLabel)
        
//        let nextWord = UIButton(type: .system)
//        nextWord.translatesAutoresizingMaskIntoConstraints = false
//        nextWord.setTitle("NEXT", for: .normal)
//        nextWord.addTarget(self, action: #selector(changeWord), for: .touchUpInside)
//        view.addSubview(nextWord)
        
        NSLayoutConstraint.activate([
            currentWord.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            currentWord.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            guessButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            guessButton.topAnchor.constraint(equalTo: currentWord.bottomAnchor, constant: 50),
            levelLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            levelLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            scoreLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            guessLabel.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 10),
            guessLabel.leftAnchor.constraint(equalTo: levelLabel.leftAnchor),
//            nextWord.topAnchor.constraint(equalTo: guessButton.bottomAnchor),
//            nextWord.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
        
        DispatchQueue.global(qos: .background).async {
            [weak self] in
                if let startWordsURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
                    if let startWords = try? String(contentsOf: startWordsURL) {
                        self?.allWords = startWords.components(separatedBy: "\n")
                    }
                }
            if self!.allWords.isEmpty {
                self?.allWords = ["antelope"]
                }
            DispatchQueue.main.async {
                self?.startGame()
                }
            }
        }
    
    func startGame() {
        word = allWords.randomElement()!
        checkLetters()
    }
    
    @objc func reset() {
        guessCount = 7
        usedLetters.removeAll()
        for element in usedWords {
            allWords.append(element)
        }
        usedWords.removeAll()
        print("Available words array size \(allWords.count)")
        print("Used words array size \(usedWords.count)")
        print(word)
        changeWord()
        print(word)
        checkLetters()
    }
    
    @objc func guessTapped() {
        let ac = UIAlertController(title: "Guess", message: "Enter a single letter", preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let letter = ac?.textFields?[0].text else { return }
            self?.submit(letter)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String) {
        if errorTitle == "Oh no!" {
            print("here")
            reset()
        }
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Clear", style: .default))
        present(ac, animated: true)
    }
    
    func showMessage(Title: String, Message: String) {
        let ac = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Clear", style: .default))
        present(ac, animated: true)
    }
    
    func submit(_ letter: String) {
        let lowerAnswer = letter.lowercased()
        if is1Character(lowerAnswer) {
            if isLetter(lowerAnswer) {
                usedLetters += [lowerAnswer]
            } else { showErrorMessage(errorTitle: "Error", errorMessage: "That was not a recognised letter") }
        } else { showErrorMessage(errorTitle: "Error", errorMessage: "Submit only 1 letter") }
        
        print(usedLetters)
        checkLetters()
    }
    
    func is1Character(_ submission: String) -> Bool {
        if submission.count == 1 { return true } else { return false }
    }
    
    func isLetter(_ submission: String) -> Bool {
        let letter = Character(submission)
        if letter.isLetter { return true } else { return false }
    }
    
    func checkLetters() {
        var promptWord = ""
        for character in word {
            let strLetter = String(character)
            if usedLetters.contains(strLetter) {
                promptWord += strLetter
            } else {
                promptWord += "?"
            }
        }
        currentWord.text = promptWord
        
        if usedLetters.count == 0 { return }
        else {
            if !word.contains(usedLetters.last!) {
                if guessCount < 2 {
                    guessCount -= 1
                    showErrorMessage(errorTitle: "Oh no!", errorMessage: "Your all out of guesses, your game will be reset")
                    return
                } else {
                    showErrorMessage(errorTitle: "Incorrect Guess", errorMessage: "That letter isn't in the word")
                    guessCount -= 1
                    return
                    }
                }
        }
        
        if checkWord(promptWord) {
            currentWord.text = promptWord
            if level == 249 {
                level += 1
                score += 1
                showMessage(Title: "WOW!", Message: "You have guessed all 250 words, the game will be reset.")
                reset()
                checkLetters()
            } else {
                showMessage(Title: "Congratulations", Message: "You guessed the letters correctly, word: \(promptWord)")
                correctWord()
                changeWord()
                checkLetters()
            }
        } else {
        currentWord.text = promptWord
            }
    }
    
    func correctWord() {
        usedWords.append(word)
        allWords.remove(at: allWords.firstIndex(of: word)!)
        print("Available words array size \(allWords.count)")
        print("Used words array size \(usedWords.count)")
        level += 1
        score += 1
        usedLetters.removeAll()
        guessCount = 7
        print(usedLetters)
    }
    
    @objc func changeWord() {
        word = allWords.randomElement()!
    }
    
    func checkWord(_ promptWord: String) -> Bool {
        if promptWord.contains("?") {
            return false
        } else {
            return true
        }
    }
}


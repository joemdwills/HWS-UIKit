//
//  ViewController.swift
//  Project28
//
//  Created by Joe Williams on 22/12/2021.
//
import LocalAuthentication
import UIKit

class ViewController: UIViewController {
    @IBOutlet var secret: UITextView!
    var done: UIBarButtonItem!
    var password: String!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Nothing to see here"
        password = KeychainWrapper.standard.string(forKey: "Password") ?? ""
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEnd = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEnd, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }

    @IBAction func authenticateTapped(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                    } else {
                        self?.failedAuthentication()
                    }
                }
            }
        } else {
            // no biometry
            self.tryPassword()
        }
    }
    
    func failedAuthentication() {
        // error
        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.addAction(UIAlertAction(title: "Use Password", style: .default) { _ in
            self.tryPassword()
        })
        self.present(ac, animated: true)
    }
    
    func tryPassword() {
        if self.password.isEmpty {
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication, create a password.", preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "Set Password", style: .default) { [weak self, weak ac] _ in
                guard let newPassword = ac?.textFields?[0].text else { return }
                KeychainWrapper.standard.set(newPassword, forKey: "Password")
                self?.password = newPassword
            })
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Enter Password", message: "Enter the correct password to unlock secrets", preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
                guard let enteredPassword = ac?.textFields?[0].text else { return }
                if self?.password == enteredPassword {
                    self?.unlockSecretMessage()
                }
            })
            present(ac, animated: true)
        }
    }
    
//    func createPassword() {
//        let ac = UIAlertController(title: "Set a password", message: "Would you like to set a password to protect your text", preferredStyle: .alert)
//        ac.addTextField()
//        ac.addAction(UIAlertAction(title: "Set Password", style: .default) { [weak self, weak ac] _ in
//            guard let newPassword = ac?.textFields?[0].text else { return }
//            self?.password = newPassword
//        })
//        present(ac, animated: true)
//    }
//
//    func checkPassword() -> Bool {
//        let ac = UIAlertController(title: "Enter Password", message: "Enter the correct password to unlock secrets", preferredStyle: .alert)
//        ac.addTextField()
//        ac.addAction(UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
//            guard let enteredPassword = ac?.textFields?[0].text else { return }
//            if self?.password == enteredPassword {
//                return true
//            } else {
//                return false
//            }
//        })
//        present(ac, animated: true)
//    }
    
    func unlockSecretMessage() {
        secret.isHidden = false
        title = "Secret Stuff"
        secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? ""
        done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(saveSecretMessage))
        navigationItem.rightBarButtonItem = done
    }
    
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()
        secret.isHidden = true
        title = "Nothing to see here"
        navigationItem.setRightBarButton(nil, animated: true)
    }
}

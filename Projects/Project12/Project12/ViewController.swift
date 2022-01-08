//
//  ViewController.swift
//  Project12
//
//  Created by Joe Williams on 20/10/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseTouchID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        defaults.set("Paul Hudson", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")

        let dict = ["Name": "Paul", "Country": "UK"]
        defaults.set(dict, forKey: "SavedDict")
        
//        When you're reading values from UserDefaults you need to check the return type carefully to ensure you know what you're getting. Here's what you need         to know:

///        integer(forKey:) returns an integer if the key existed, or 0 if not.
///        bool(forKey:) returns a boolean if the key existed, or false if not.
///        float(forKey:) returns a float if the key existed, or 0.0 if not.
///        double(forKey:) returns a double if the key existed, or 0.0 if not.
///        object(forKey:) returns Any? so you need to conditionally typecast it to your data type.
        
//        Knowing the return values are important, because if you use bool(forKey:) and get back "false", does that mean the key didn't exist, or did it perhaps        exist and you just set it to be false?
        
        
        let savedInteger = defaults.integer(forKey: "Age")
        let savedBoolean = defaults.bool(forKey: "UseFaceID")
        
        
        let savedArray = defaults.object(forKey: "savedArray") as? [String] ?? [String]()
    }


}


//
//  ViewController.swift
//  Project4
//
//  Created by Joe Williams on 22/09/2021.
//

import UIKit
import WebKit

class ViewController: UITableViewController {
    var websites = ["apple.com","hackingwithswift.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pick a website"
//        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedWebsite = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            vc.websites = websites
        }
    }
}

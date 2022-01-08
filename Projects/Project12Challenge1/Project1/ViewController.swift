//
//  ViewController.swift
//  Project1
//
//  Created by Joe Williams on 06/09/2021.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var counts = [String: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommendation))
        
        performSelector(inBackground: #selector(loadPictures), with: nil)
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: true)
        
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "counts") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                counts = try jsonDecoder.decode([String: Int].self, from: savedData)
            } catch {
                print("Failed to load counts")
            }
        }
        
        tableView.reloadData()
    }
    
    @objc func loadPictures() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load!
                pictures.append(item)
                counts[item] = 0
            }
        }
        pictures.sort()
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.detailTextLabel?.text = "\(counts[pictures[indexPath.row]] ?? 999)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        counts["\(pictures[indexPath.row])"]! += 1
        tableView.reloadData()
        save()
//        print("hello")
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            vc.selectedPictureNumber = indexPath.row + 1
            vc.totalPictures = pictures.count
        }
    }
    
    @objc func recommendation() {
        let text = "This is my favourite app"
        let ac = UIActivityViewController(activityItems: [text], applicationActivities: [])
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(counts) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "counts")
        } else {
            print("Failed to save open counts...")
        }
    }
}

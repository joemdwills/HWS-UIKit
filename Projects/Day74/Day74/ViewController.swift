//
//  ViewController.swift
//  Day74
//
//  Created by Joe Williams on 23/11/2021.
//

import UIKit

class ViewController: UITableViewController, UINavigationControllerDelegate {
    var notes = [Note]()
    var compose: UIBarButtonItem!
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
//      navigationController?.navigationBar.prefersLargeTitles = true
        
        compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(newNote))
        navigationItem.rightBarButtonItem = compose
        
        let defaults = UserDefaults.standard
        if let savedNotes = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                notes = try jsonDecoder.decode([Note].self, from: savedNotes)
            } catch {
                print("Failed to load notes")
            }
        }
//        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: true)
//        toolbarItems = [compose]
//        navigationController?.isToolbarHidden = false
    }
    
    @objc func newNote() {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            count += 1
            notes.append(Note(title: "placeholder\(count)", text: " "))
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.delegate = self
            vc.selectedNote = indexPath.row
            vc.note = notes[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            print("Failed to save the notes")
        }
    }


}


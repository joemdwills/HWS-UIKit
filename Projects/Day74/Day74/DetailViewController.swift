//
//  DetailViewController.swift
//  Day74
//
//  Created by Joe Williams on 03/12/2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var textView: UITextView!
    var note: Note!
    var compose: UIBarButtonItem!
    var selectedNote: Int!
    weak var delegate: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareNote))
        
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        delete.tintColor = .systemYellow
        
        textView.text = note.text
        
        toolbarItems = [delete]
        navigationController?.isToolbarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        note.title = getTitle(textView.text)
        delegate.notes[selectedNote] = note
        delegate.save()
        delegate.tableView.reloadData()
    }
    

    @objc func deleteNote() {
        delegate.notes.remove(at: selectedNote)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func shareNote() {
        
    }
    
    func checkNote() {
        
    }
    
    func getTitle(_ text: String) -> String {
        var title: String
        var lines = [String]()
        
        if textView.text.count > 0 {
            lines = textView.text.components(separatedBy: "\n")
            title = lines[0]
        } else {
            title = "Empty Note"
        }
        return title
    }
}

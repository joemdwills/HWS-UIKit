//
//  ViewController.swift
//  Project7
//
//  Created by Joe Williams on 27/09/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let credit = UIBarButtonItem(title: "Credits", style: .done, target: self, action: #selector(showCredits))
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filterList))
        navigationItem.rightBarButtonItems = [credit, search]
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                filteredPetitions = petitions
                return
            }
        }
        showError()
        }
    
    @objc func filterList() {
        let ac = UIAlertController(title: "Petition contains:", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitFilter = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let filter = ac?.textFields?[0].text else { return }
            self?.submit(filter)
            }
        ac.addAction(submitFilter)
        present(ac, animated: true)
        }

    func submit(_ filter: String) {
        filteredPetitions.removeAll(keepingCapacity: true)
        for petition in petitions {
            if petition.title.lowercased().contains(filter.lowercased()) {
                filteredPetitions.append(petition)
            } else if petition.body.lowercased().contains(filter.lowercased()) {
                filteredPetitions.append(petition)
            }
            tableView.reloadData()
            }

        if filteredPetitions.count == 0 {
            showFilterError()
            filteredPetitions = petitions
            tableView.reloadData()
        }
    }
        
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credit goes to:", message: "We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was an issue loading the feed, please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func showFilterError() {
        let ac = UIAlertController(title: "None Found", message: "Your search didn't yield any results", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}


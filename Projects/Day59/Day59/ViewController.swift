//
//  ViewController.swift
//  Day59
//
//  Created by Joe Williams on 29/10/2021.
//

import UIKit

class TableViewController: UITableViewController {
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "10 Country Facts"
        
        if let localData = readLocalFile(forName: "Facts") {
            self.parse(json: localData)
        }
    }
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("error")
        }
        print("error2")
        return nil
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
//        print("Parsing1...")

        if let jsonCountries = try? decoder.decode(Countries.self, from: json) {
            countries = jsonCountries.results
//            print(countries)
//            print("Parsing2...")
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.Name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
        vc.detailedCountry = countries[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        }
    }


}


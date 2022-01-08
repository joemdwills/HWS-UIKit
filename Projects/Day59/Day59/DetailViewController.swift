//
//  DetailViewController.swift
//  Day59
//
//  Created by Joe Williams on 01/11/2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var capital: UILabel!
    @IBOutlet var area: UILabel!
    @IBOutlet var population: UILabel!
    @IBOutlet var currency: UILabel!
    
    
    var detailedCountry: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = detailedCountry?.Name
        navigationItem.largeTitleDisplayMode = .always
        
        
        capital.text = detailedCountry?.Info.Capital
        area.text = "\(detailedCountry?.Info.Area ?? 999)"
        population.text = "\(detailedCountry?.Info.Population ?? 999)"
        currency.text = detailedCountry?.Info.Currency
       
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        
        if let imageToLoad = detailedCountry?.Name {
//            print(":(")
            imageView.image = UIImage(named: imageToLoad)
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

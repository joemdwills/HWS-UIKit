//
//  DetailViewController.swift
//  Day50
//
//  Created by Joe Williams on 23/10/2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedPhoto: Photo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedPhoto?.caption
        let path = getDocumentsDirectory().appendingPathComponent(selectedPhoto!.image)
        imageView.image = UIImage(contentsOfFile: path.path)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
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

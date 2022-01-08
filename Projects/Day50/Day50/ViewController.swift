//
//  ViewController.swift
//  Day50
//
//  Created by Joe Williams on 23/10/2021.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takePhoto))
        title = "Take Photos"
        
        let defaults = UserDefaults.standard
        
        if let savedPhotos = defaults.object(forKey: "photos") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                photos = try jsonDecoder.decode([Photo].self, from: savedPhotos)
            } catch {
                print("Unable to load photos")
            }
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // fix the selected image here
        let selected = photos[indexPath.item]
        cell.textLabel?.text = selected.caption
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
        vc.selectedPhoto = photos[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc func takePhoto() {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.delegate = self
            present(picker, animated: true)
        } else {
            return
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
    
        guard let image = info[.originalImage] as? UIImage else {
            print("No Image Found")
            return
        }
        
        let newImage = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(newImage)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let photo = Photo(image: newImage, caption: "Placeholder Text")
        let captionedPhoto = writeCaption(photo) 
        photos.append(captionedPhoto)
        save()
//        tableView.reloadData()
    }
    
    func writeCaption(_ photo: Photo) -> Photo {
        let photo = photo
        let ac = UIAlertController(title: "Caption", message: "Enter a caption to remember this photo", preferredStyle: .alert)
        ac.addTextField()
        let submitCaption = UIAlertAction(title: "Submit", style: .default) { [weak ac] _ in
            guard let caption = ac?.textFields?[0].text else {
                print("Caption not present")
                return
            }
            photo.caption = caption
            self.save()
            self.tableView.reloadData()
        }
        ac.addAction(submitCaption)
        present(ac, animated: true)
        return photo
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save() {
        let jsonEnconder = JSONEncoder()
        
        if let savedPhotos = try? jsonEnconder.encode(photos) {
            let defaults = UserDefaults.standard
            defaults.set(savedPhotos, forKey: "photos")
        } else {
            print("Unable to save data")
        }
    }
}


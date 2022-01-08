//
//  ViewController.swift
//  Project16
//
//  Created by Joe Williams on 02/11/2021.
//
import MapKit
import UIKit
import WebKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var mapStyle: UIButton!
    
    let wikiButton = UIButton(type: .detailDisclosure)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the city of Light")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        let identifier = "Capital"

        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView.annotation = annotation
        annotationView.canShowCallout = true
        let btn = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = btn
        annotationView.pinTintColor = UIColor.green
        return annotationView
        
        
//        if annotationView == nil {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            annotationView?.canShowCallout = true
//            let btn = UIButton(type: .detailDisclosure)
//            annotationView?.rightCalloutAccessoryView = btn
//        } else {
//            annotationView?.annotation = annotation
//            annotationView?.pinTintColor = UIColor.green
//        }
//        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let vc = WebViewController()
        vc.wikiSite = capital.title
        navigationController?.pushViewController(vc, animated: true)
        
//        let placeName = capital.title
//        let placeInfo = capital.info
//
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "Ok", style: .default))
//        present(ac, animated: true)
    }
    
    @IBAction func mapStyle(_ sender: UIButton) {
        let ac = UIAlertController(title: "Pick Map Style", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: setMapStyle))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: setMapStyle))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: setMapStyle))
//        ac.addAction(UIAlertAction(title: "Satellite Flyover", style: .default, handler: setMapStyle))
//        ac.addAction(UIAlertAction(title: "Hybrid Flyover", style: .default, handler: setMapStyle))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popOverController = ac.popoverPresentationController {
            popOverController.sourceView = sender
            popOverController.sourceRect = sender.bounds
        }
        present(ac, animated: true)
    }
    
    func setMapStyle(action: UIAlertAction) {
        if action.title == "Standard" {
            mapView.mapType = .standard
        }
        if action.title == "Satellite" {
            mapView.mapType = .satellite
        }
        if action.title == "Hybrid" {
            mapView.mapType = .hybrid
        }
//        if action.title == "Satellite Flyover" {
//            mapView.mapType = .satelliteFlyover
//        }
//        if action.title == "Hybrid Flyover" {
//            mapView.mapType = .hybridFlyover
//        }
    }
    
    
    
    
}


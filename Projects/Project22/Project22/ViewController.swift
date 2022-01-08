//
//  ViewController.swift
//  Project22
//
//  Created by Joe Williams on 04/12/2021.
//
import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var distanceReading: UILabel!
    @IBOutlet var beaconLabel: UILabel!
    @IBOutlet var homingBeacon: UIImageView!
    var locationManager: CLLocationManager?
    var beaconDetected = false
    var uuidArray = [UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5"), UUID(uuidString: "74278BDA-B644-4520-8F0C-720EAF059935"), UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")]
    var uuidText: String = ""
    var circleBeacon: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        view.backgroundColor = .lightGray
        beaconLabel.text = "Beacon No."
        beaconLabel.layer.zPosition = 1
        distanceReading.layer.zPosition = 1
        let rect = CGRect(x: 0, y: 0, width: 350, height: 350)
        circleBeacon = UIView(frame: rect)
        circleBeacon.center = CGPoint(x: view.center.x, y: view.center.y)
        circleBeacon.layer.cornerRadius = 175
        circleBeacon.backgroundColor = .gray
        circleBeacon.alpha = 0.5
        circleBeacon.layer.zPosition = 0
        view.addSubview(circleBeacon)
        
//        NSLayoutConstraint.activate([
//            circleBeacon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            circleBeacon.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//        homingBeacon.image = UIImage(named: "homingBeacon")
//        homingBeacon.layer.borderWidth = 2
//        homingBeacon.layer.borderColor = CGColor(srgbRed: 1, green: 0, blue: 255, alpha: 100)
//        homingBeacon.layer.zPosition = 0
//        view.addSubview(homingBeacon)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    var count = 0
                    for uuid in uuidArray {
                        count += 1
                        startScanning(uuid: uuid!, major: 123, minor: 456, identifier: "Beacon \(count)")
                    }
                }
            }
        }
    }
    
    func startScanning(uuid: UUID, major: CLBeaconMajorValue, minor: CLBeaconMinorValue, identifier: String) {
        let beaconIdentity = CLBeaconIdentityConstraint(uuid: uuid, major: major, minor: minor)
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: beaconIdentity, identifier: identifier)
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: beaconIdentity)
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.5) {
            switch distance {
            case .far:
//                self.view.backgroundColor = .blue
                self.distanceReading.text = "far"
//                self.homingBeacon.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                self.circleBeacon.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.circleBeacon.backgroundColor = .red
                
            case .near:
//                self.view.backgroundColor = .orange
                self.distanceReading.text = "near"
//                self.homingBeacon.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.circleBeacon.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.circleBeacon.backgroundColor = .orange
                
            case .immediate:
//                self.view.backgroundColor = .red
                self.distanceReading.text = "right here"
//                self.homingBeacon.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.circleBeacon.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                self.circleBeacon.backgroundColor = .green
                
            default:
//                self.view.backgroundColor = .gray
                self.distanceReading.text = "unkown"
//                self.beaconLabel.text = "beacon"
//                self.homingBeacon.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.circleBeacon.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            if beaconDetected == false {
                let ac = UIAlertController(title: "Beacon Detected", message: "Beacon with UUID: \(beacon.uuid) was detected", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                beaconDetected.toggle()
                present(ac, animated: true)
            }
            updateBeaconLabel(beacon: beacon)
        } else {
            beaconLabel.text = "Beacon No."
        }
    }
    
    func updateBeaconLabel(beacon: CLBeacon) {
        if beacon.uuid == uuidArray[0] {
            beaconLabel.text = "beacon 1"
            update(distance: beacon.proximity)
            return
        } else if beacon.uuid == uuidArray[1] {
            beaconLabel.text = "beacon 2"
            update(distance: beacon.proximity)
            return
        } else if beacon.uuid == uuidArray[2] {
            beaconLabel.text = "beacon 3"
            update(distance: beacon.proximity)
            return
        }
    }
}


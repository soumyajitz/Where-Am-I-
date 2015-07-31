//
//  ViewController.swift
//  Where Am I?
//
//  Created by Soumyajit Sarkar on 7/30/15.
//  Copyright (c) 2015 Raul. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    var manager:CLLocationManager!

    @IBOutlet var latLabel: UILabel!
  
    @IBOutlet var longLabel: UILabel!
    
    @IBOutlet var courseLabel: UILabel!
    
    @IBOutlet var addressLabel: UILabel!
    
    @IBOutlet var altLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println(locations)
        var userLocation = locations[0] as! CLLocation
        self.latLabel.text = "\(userLocation.coordinate.latitude)"
        self.longLabel.text = "\(userLocation.coordinate.longitude)"
        self.courseLabel.text = "\(userLocation.course)"
        self.speedLabel.text = "\(userLocation.speed)"
        self.altLabel.text = "\(userLocation.altitude)"
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            if(error != nil){
                println(error)
            }
            else
            {
                if let p = CLPlacemark(placemark: placemarks?[0] as! CLPlacemark){
                    var subThoroughfare:String = "-"
                    if (p.subThoroughfare != nil){
                    subThoroughfare = p.subThoroughfare
                    }
            self.addressLabel.text = "\(subThoroughfare) \n \(p.thoroughfare) \n \(p.subLocality) \(p.subAdministrativeArea) \n \(p.postalCode) \n \(p.country)"
                }
            }
        })
    }

    override
    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


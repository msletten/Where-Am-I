//
//  ViewController.swift
//  Where Am I
//
//  Created by Mat Sletten on 1/21/15.
//  Copyright (c) 2015 Mat Sletten. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var myLocation:CLLocationManager!
    //can use var myLocation = CLLocationManager() in place of above
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myLocation = CLLocationManager()
        myLocation.delegate = self
        myLocation.desiredAccuracy = kCLLocationAccuracyBest
        myLocation.requestWhenInUseAuthorization()
        myLocation.startUpdatingLocation()
    }
    
    func locationManager(myLocation: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation:CLLocation = locations[0] as CLLocation
        
        latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        speedLabel.text = "\(userLocation.speed)"
        courseLabel.text = "\(userLocation.course)"
        altitudeLabel.text = "\(userLocation.altitude)"
        //Below we use a method to find the addresses of nearby places according to our location
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler:{(placemarks, error) in
            if error != nil {println(error)}
            else {
                println(placemarks)
                let place = CLPlacemark(placemark: placemarks?[0] as CLPlacemark)
                var addressNumber:String
                if (place.subThoroughfare != nil) {
                    addressNumber = place.subThoroughfare
                }
                else {
                    addressNumber = ""
                }
                self.addressLabel.text = "\(place.subLocality)\n\(addressNumber) \(place.thoroughfare)\n\(place.subAdministrativeArea), \(place.administrativeArea)\n\(place.country)"
            }
        })
        //println(userLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


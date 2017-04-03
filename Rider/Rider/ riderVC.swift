//
//  riderVC.swift
//  Rider
//
//  Created by Bryant Acosta on 3/6/17.
//  Copyright © 2017 Bryant Acosta. All rights reserved.
//

import UIKit
import MapKit

class RiderVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var myMap: MKMapView!
   
    private var locationManager = CLLocationManager();
    private var userLocation: CLLocationCoordinate2D?;
    private var driverLocaion: CLLocationCoordinate2D?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeLocationManager();
    }
    
    
    private func initializeLocationManager() {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]){
        // if we have location points from manager
        if let location = locationManager.location?.coordinate {
            
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            let region = MKCoordinateRegion(center: userLocation!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01));
            
            myMap.setRegion(region, animated: true)
            
            myMap.removeAnnotations(myMap.annotations);
            
            
            let annotation = MKPointAnnotation();
            annotation.coordinate = userLocation!;
            annotation.title = "Drivers Location";
            myMap.addAnnotation(annotation);
        }
    }
    
    @IBAction func callUber(_ sender: AnyObject) {
        uberHandler.Instance.requestUber(latitude: Double(userLocation!.latitude), longitude: Double(userLocation!.longitude))
    }
    
    @IBAction func logOut(_ sender: AnyObject) {
        if AuthProvider.Instance.logOut() {
            dismiss(animated: true, completion: nil);
        } else {
            // problem with loging out
            alertTheUser(title: "Could Not Logout", message: "We could not logout at the moment, please try again later");
        }
    }
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
        
    }
    
} // class



































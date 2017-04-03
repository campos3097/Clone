//
//  DriverVC.swift
//  Driver app
//
//  Created by Bryant Acosta on 4/1/17.
//  Copyright © 2017 Bryant Acosta. All rights reserved.
//

import UIKit
import MapKit


class DriverVc: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UberController {
    
    
    
    @IBOutlet weak var myMap: MKMapView!
    
    private var locationManager = CLLocationManager();
    private var userLocation: CLLocationCoordinate2D?;
    private var riderLocation: CLLocationCoordinate2D?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeLocationManager()
        
        UberHandler.Instance.delegate = self;
        UberHandler.Instance.observeMessagesForDriver();
    }
  
    
    private func initializeLocationManager() {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // if we have the coordinates from the manager
        if let location = locationManager.location?.coordinate {
            
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            let region = MKCoordinateRegion(center: userLocation!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01));
            
            myMap.setRegion(region, animated: true);
            
            myMap.removeAnnotations(myMap.annotations); 
            
            let annotation = MKPointAnnotation();
            annotation.coordinate = userLocation!;
            annotation.title = "Drivers Location";
            myMap.addAnnotation(annotation);
            

            
        }
        
    }
    func acceptUber(lat: Double, long: Double) {
        uberRequest(title: "Uber Request", message: "You have a request for an uber at this location Lat: \(lat), Long: \(long)", requestAlive: true);

    }
    
    @IBAction func cancelUber(_ sender: Any) {
    }
  
    
    @IBAction func LogOut(_ sender: Any) {
        if AuthProvider.Instance.logOut() {
            dismiss(animated: true, completion: nil);
        }else{
                // problem with loging out
                uberRequest(title: "Could Not Logout", message: "We could not logout at the moment, please try again later", requestAlive: false)
            } 
  
    }
    
    private func uberRequest(title: String, message: String, requestAlive: Bool) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        
        if requestAlive {
            let accept = UIAlertAction(title: "Accept", style: .default, handler: { (alertAction: UIAlertAction) in
                
            });
            
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil);
            
            alert.addAction(accept);
            alert.addAction(cancel);
            
        } else {
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
            alert.addAction(ok);
        }
        
        present(alert, animated: true, completion: nil);
    }

    
}

//
//  UberHandler.swift
//  Driver app
//
//  Created by Bryant Acosta on 4/2/17.
//  Copyright © 2017 Bryant Acosta. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol UberController: class {
    func acceptUber(lat: Double, long: Double);
//    func riderCanceledUber();
//    func uberCanceled();
//    func updateRidersLocation(lat: Double, long: Double);
}


class UberHandler {
   private static let _instance = UberHandler();
    
    weak var delegate: UberController?;
    
    var rider = "";
    var driver = "";
    var driver_id = "";
    
    static var Instance: UberHandler {
        return _instance;
    }

    func observeMessagesForDriver() {
        // RIDER REQUESTED AN UBER
        DBProvider.Instance.requestRef.observe(FIRDataEventType.childAdded) { (snapshot: FIRDataSnapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                if let latitude = data[Constants.LATITUDE] as? Double {
                    if let longitude = data[Constants.LONGITUDE] as? Double {
                        self.delegate?.acceptUber(lat: latitude, long: longitude);
                    }

                }
            
            }

        }
    
    }
}










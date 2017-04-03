//
//  uberHandler.swift
//  Rider
//
//  Created by Bryant Acosta on 3/20/17.
//  Copyright © 2017 Bryant Acosta. All rights reserved.
//

import Foundation
import FirebaseDatabase

class uberHandler {
    private static let _instance = uberHandler();
   
    var rider = "";
    var driver = "";
    var rider_id = "";
    
    static var Instance: uberHandler{
        return _instance;

    }
    
    func requestUber(latitude: Double, longitude: Double) {
        let data: Dictionary<String, Any> = [Constant.NAME: rider, Constant.LATITITUDE: latitude, Constant.LONGITUDE: longitude];
        
        DBProvider.Instance.requestRef.childByAutoId().setValue(data);
    
        
        
    }// request uber
    
} // class

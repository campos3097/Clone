//
//  DBreference.swift
//  Driver app
//
//  Created by Bryant Acosta on 4/2/17.
//  Copyright © 2017 Bryant Acosta. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBProvider {
    private static let _instance = DBProvider();
    
    static var Instance: DBProvider {
        return _instance;
    }
    var dbRef: FIRDatabaseReference {
        return FIRDatabase.database().reference();
    }
    
    var driversRef: FIRDatabaseReference {
        return dbRef.child(Constants.DRIVERS);
    }
    
    var requestRef: FIRDatabaseReference{
        return dbRef.child(Constants.UBER_REQUEST)
    }
    var requestAcceptedRef: FIRDatabaseReference{
        return dbRef.child(Constants.UBER_ACCEPTED)
    }
    //  requestAccepted
    
    func saveUser(withID: String, email: String, password: String) {
        let data: Dictionary<String, Any> = [Constants.EMAIL: email, Constants.PASSWORD: password, Constants.isRider: false];
        driversRef.child(withID).child(Constants.DATA).setValue(data);
    }
    
}//class





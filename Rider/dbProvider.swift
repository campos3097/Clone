//
//  dbProvider.swift
//  Rider
//
//  Created by Bryant Acosta on 3/9/17.
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
    
    var RidersRef: FIRDatabaseReference {
        return dbRef.child(Constant.RIDER);
    }
    
    var requestRef: FIRDatabaseReference{
        return dbRef.child(Constant.UBER_REQUEST)
    }
    var requestAcceptedRef: FIRDatabaseReference{
        return dbRef.child(Constant.UBER_ACCEPTED)
    }
   //  requestAccepted
    
    func saveUser(withID: String, email: String, password: String) {
        let data: Dictionary<String, Any> = [Constant.EMAIL: email, Constant.PASSWORD: password, Constant.isRider: true];
        RidersRef.child(withID).child(Constant.DATA).setValue(data);
    }
    
}//class

























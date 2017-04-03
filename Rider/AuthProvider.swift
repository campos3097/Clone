//
//  AuthProvider.swift
//  Rider
//
//  Created by Bryant Acosta on 3/2/17.
//  Copyright © 2017 Bryant Acosta. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias LogInHandler = (_ message:String?) -> Void;

struct  LogInErrorCode {
 
    
    static let INVALID_EMAIL = "Invalid Email Adress, Please Provide A Real Email Address";
    static let WRONG_PASSWORD = "Wrong Password, Please Try Again";
    static let PROBLEM_CONNECTING = "Problem Connecting To The Data Base, Please Try Again Later ";
    static let USER_NOT_FOUND = "User Not Found, Please Register";
    static let EMAIL_ALREADY_IN_USE = "Email Already In Use, Please Try again";
    static let WEAK_PASSWORD = "Password Must Be Atleast 6 Charchters Long";
    


}
class AuthProvider {
    private static let _instance = AuthProvider();
    
    static var Instance: AuthProvider {
        return _instance;
    }
    
    func login(withEmail: String, password: String, loginHandler: LogInHandler?) {
        
        FIRAuth.auth()?.signIn(withEmail: withEmail, password: password, completion: { (user, error) in
            
            if error != nil {
                self.handleErrors(err: error as! NSError, loginHandler: loginHandler);
            } else {
                loginHandler?(nil);
                
                }
            
        });
}// login func
    
    func signUp(withEmail: String, password: String, loginHandler: LogInHandler?) {
        
        FIRAuth.auth()?.createUser(withEmail: withEmail, password: password, completion: { (user, error) in
            
            if error != nil {
                self.handleErrors(err: error as! NSError, loginHandler: loginHandler);
            } else {
                
                if user?.uid != nil {
                    
                    // store the user to database
                    DBProvider.Instance.saveUser(withID: user!.uid, email: withEmail, password: password);
                    
                    // login the user
                    self.login(withEmail: withEmail, password: password, loginHandler: loginHandler);
                    
                }
                
            }
            
        });
    } // sign up func
    
    func logOut()->Bool {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut();
                return true;
            }catch {
                return false;
            }
        }
    return true;
}

private func handleErrors(err: NSError, loginHandler: LogInHandler?){
    
    if let errCode = FIRAuthErrorCode(rawValue: err.code){
        
        switch errCode {
        case .errorCodeWrongPassword:
            loginHandler?(LogInErrorCode.WRONG_PASSWORD);
            break;
        case .errorCodeInvalidEmail:
            loginHandler?(LogInErrorCode.INVALID_EMAIL);

            break;
        case .errorCodeUserNotFound:
            loginHandler?(LogInErrorCode.USER_NOT_FOUND);

            break;
        case .errorCodeEmailAlreadyInUse:
            loginHandler?(LogInErrorCode.EMAIL_ALREADY_IN_USE);
            break;
        case .errorCodeWeakPassword:
            loginHandler?(LogInErrorCode.WEAK_PASSWORD);
            break;

            
        default:
            loginHandler?(LogInErrorCode.PROBLEM_CONNECTING);
            break;
            
        
        }
        
    }
    
}


}// class


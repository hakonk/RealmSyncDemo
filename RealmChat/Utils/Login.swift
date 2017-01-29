//
//  Login.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 29/01/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import Foundation
import RealmSwift

fileprivate enum LoginError: ErrorConvenience{
    case wrongUserNamePassword, insufficientInput
    
    var error: NSError{
        switch self{
        case .wrongUserNamePassword:
            return NSError(domain: "no.realmchat.login", code: -999, userInfo: [NSLocalizedDescriptionKey:"Invalid password or username"])
        case .insufficientInput:
            return NSError(domain: "no.realmchat.login", code: -998, userInfo: [NSLocalizedDescriptionKey:"Insufficient input"])
        }
    }
}

struct LoginHelper{
    
    let username: String
    let password: String
    let register: Bool
    
    private func config(){
        
    }
    
    private var isInputValid: Bool{
        return !username.isEmpty && !password.isEmpty
    }
    
    private func urlFrom(host: String) -> URL{
        return URL(string: "http://\(host):9080")!
    }
    
    func authenticate(authHost: String, callback: @escaping (SyncUser?, NSError?) -> Void) {
        guard isInputValid else {
            callback(nil, LoginError.insufficientInput.error)
            return
        }
        
        let credentials = SyncCredentials.usernamePassword(username: username, password: password, register: register)
        SyncUser.logIn(with: credentials, server: urlFrom(host: authHost)) { user, error in
            DispatchQueue.main.async {
                let error = error as NSError?
                
                if let error = error, error._code == SyncError.httpStatusCodeError.rawValue && (error.userInfo["statusCode"] as? Int) == 400 {
                    callback(nil, LoginError.wrongUserNamePassword.error)
                } else {
                    callback(user, error)
                }
            }
        }
    }
}

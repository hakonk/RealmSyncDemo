//
//  User.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 30/01/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import Foundation
import RealmSwift

extension SyncUser{
    static var currentUserLoggedIn: Bool{
        return SyncUser.current != nil
    }
    
    static func logOutAllUsers(){
        for (_, user) in SyncUser.__allUsers(){
            user.logOut()
        }
    }
}

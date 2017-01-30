//
//  User.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 30/01/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import Foundation
import RealmSwift

struct User{
    /// - important: Only takes into account a single user at a time. Thus, if multiple users are logged in at the same time, this computed property is `true` for any logged in user.
    static var isLoggedIn: Bool{
        for (_, user) in SyncUser.__allUsers(){
            switch user.state{
            case .active:
                return true
            default: break
            }
        }
        return false
    }
    static func logOutAllUsers(){
        for (_, user) in SyncUser.__allUsers(){
            user.logOut()
        }
    }
}

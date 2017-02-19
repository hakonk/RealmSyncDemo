//
//  RealmHelper.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 06/02/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmHelper{
    static var Host = "127.0.0.1"
    
    static func configureWithCurrentUser(with host: String = Host) -> Bool {
        if let user = SyncUser.current {
            configure(user: user, with: host)
            return true
        }
        return false
    }
    
    static func configure(user: SyncUser, with host: String = Host){
        let urlString = "realm://\(host):9080/~/burritos"
        let syncUrl = URL(string: urlString)!
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            syncConfiguration: SyncConfiguration(user: user, realmURL: syncUrl),
            objectTypes: [Burrito.self])
    }
}

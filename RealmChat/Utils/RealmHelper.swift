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
    static var DefaultHost = "127.0.0.1"
    
    static func configureWithCurrentUser(with host: String = DefaultHost) -> Bool {
        if let user = SyncUser.current {
            configure(user: user, with: host)
            return true
        }
        return false
    }
    
    static func configure(user: SyncUser, with host: String = DefaultHost){
        let urlString = "realm://\(host):9080/\(user.identity ?? "")/chatMessages"
        let syncUrl = URL(string: urlString)!
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            syncConfiguration: SyncConfiguration(user: user, realmURL: syncUrl),
            objectTypes: ModelUtil.modelTypes)
        addIfEmpty()
    }
    
    private static func addIfEmpty(){
        let realm = try! Realm()
        if realm.isEmpty {
            try! realm.write {
                let chatRoom = ChatRoom()
                chatRoom.members = "Test chat room"
                var chatMessages = List<ChatMessage>()
                for i in 0 ... 3{
                    chatMessages.append(ChatMessage(text: "message - \(i)"))
                }
                chatRoom.messages = chatMessages
                realm.add(chatRoom)
            }
        }
    }
    
}

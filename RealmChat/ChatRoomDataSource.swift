//
//  ChatRoomDataSource.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 31/01/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import Foundation
import RealmSwift

protocol StoreListener: class{
    func storeUpdated()
}

final class ChatRoomsStore: Store{
    
    override init(){
        super.init()
        
        observerToken = chatRooms.addNotificationBlock {_ in
            let realm = try! Realm()
            self.chatRooms = realm.objects(ChatRoom.self)
            self.listener?.storeUpdated()
        }
    }
    
    func add(room: ChatRoom){
        let realm = try! Realm()
        try! realm.write {
            realm.add(room)
        }
    }
    
    func room(at index: Int) -> ChatRoom{
        return chatRooms[index]
    }
    
    private var observerToken: NotificationToken?
    fileprivate lazy var chatRooms: Results<ChatRoom> = try! Realm().objects(ChatRoom.self)
}

extension ChatRoomsStore: UITableViewDataSource{
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }
    func tableView(_ _: UITableView, numberOfRowsInSection _: Int) -> Int {
        return chatRooms.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRoomCell", for: indexPath)
        cell.textLabel?.text = chatRooms[indexPath.row].members
        cell.selectionStyle = .none
        return cell
    }
}


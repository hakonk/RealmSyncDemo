//
//  ChatRoomDataSource.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 31/01/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import Foundation
import RealmSwift

private func fetchChatRooms() -> Results<ChatRoom>{
    let realm = try! Realm()
    let chatRoomsResults = realm.objects(ChatRoom.self)
    return chatRoomsResults
}

final class ChatRoomDataSource: NSObject{
    
    func fetchObjects(){
        chatRooms = fetchChatRooms()
    }
    
    func room(at index: Int) -> ChatRoom{
        return chatRooms[index]
    }
    
    lazy var chatRooms: Results<ChatRoom> = fetchChatRooms()
}

extension ChatRoomDataSource: UITableViewDataSource{
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

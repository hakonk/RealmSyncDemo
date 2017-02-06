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
    return realm.objects(ChatRoom.self)
}

final class ChatRoomsDataSource: NSObject{
    
    func fetchObjects(){
        chatRooms = fetchChatRooms()
    }
    
    func room(at index: Int) -> ChatRoom{
        return chatRooms[index]
    }
    
    lazy var chatRooms: Results<ChatRoom> = fetchChatRooms()
}

extension ChatRoomsDataSource: UITableViewDataSource{
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

final class MessageStore: NSObject{
    fileprivate var messages: List<ChatMessage>
    private let token: NotificationToken
    private let collectionView: UICollectionView
    init(with collectionView: UICollectionView, messages: List<ChatMessage>){
        self.messages = messages
        self.collectionView = collectionView
        self.token = self.messages.addNotificationBlock { change in
            collectionView.reloadData()
        }
        super.init()
    }
}

extension MessageStore: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.textLabel.text = messages[indexPath.item].text
        return cell
    }
}


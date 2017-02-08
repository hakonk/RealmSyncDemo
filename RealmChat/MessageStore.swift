//
//  MessageStore.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 08/02/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import Foundation
import RealmSwift

class Store: NSObject{
    weak var listener: StoreListener?
}

final class MessageStore: Store{
    fileprivate var chatRoom: ChatRoom
    private var token: NotificationToken?
    
    func append(message: ChatMessage){
        let realm = try! Realm()
        try! realm.write {
            chatRoom.messages.append(message)
            realm.add(chatRoom, update: true)
        }
    }
    
    init(with chatRoom: ChatRoom){
        self.chatRoom = chatRoom
        super.init()
        
        self.token = self.chatRoom.addNotificationBlock { change in
            self.listener?.storeUpdated()
        }
    }
}

extension MessageStore: UICollectionViewDataSource{
    func collectionView(_ _: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return chatRoom.messages.count
    }
    
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.textLabel.text = chatRoom.messages[indexPath.item].text
        return cell
    }
}

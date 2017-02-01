//
//  ChatRoomViewController.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 01/02/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

final class ChatRoomViewController: UIViewController{
    //MARK: Properties
    var chatRoom: ChatRoom?
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var textField: UITextField!
    
    @IBAction private func tappedSendButton(_ _: UIButton) {
        guard let chatRoom = self.chatRoom else {return}
        let realm = try! Realm()
        try! realm.write {
            
            let text = textField.text ?? ""
            let chatMessage = ChatMessage(text: text)
            chatRoom.messages.append(chatMessage)
            realm.add(chatRoom, update: true)
        }
    }
}

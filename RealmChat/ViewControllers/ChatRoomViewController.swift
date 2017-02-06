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
    //TODO: Rather add the store here
    var chatRoom: ChatRoom?
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var textField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        chatRoom?.messages.forEach{
            print($0.text)
        }
    }
    
    @IBAction private func tappedSendButton(_ _: UIButton) {
        guard let chatRoom = self.chatRoom,
            let text = textField.text,
            text.characters.count > 0
            else {return}
        
        let realm = try! Realm()
        try! realm.write {
            let chatMessage = ChatMessage(text: text)
            chatRoom.messages.append(chatMessage)
            realm.add(chatRoom, update: true)
        }
    }
}

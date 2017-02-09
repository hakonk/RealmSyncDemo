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
    
    var messageStore: MessageStore?
    @IBOutlet private (set) weak var collectionView: UICollectionView!
    @IBOutlet private (set) weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = messageStore
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction private func tappedSendButton(_ _: UIButton) {
        guard let messageStore = self.messageStore,
            let text = textField.text,
            text.characters.count > 0
            else {return}
        messageStore.appendMessage(with: text)
        
    }
}

extension ChatRoomViewController: StoreListener{
    func storeUpdated(){
        collectionView.reloadData()
    }
}

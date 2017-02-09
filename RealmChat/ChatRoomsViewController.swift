//
//  ViewController.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 29/01/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import UIKit
import RealmSwift

final class ChatRoomsViewController: UIViewController {
    
    @IBOutlet private weak var logOutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        tableView.dataSource = self.dataSource
        tableView.delegate = self
        dataSource.listener = self
        dataSource.setup()
        super.viewDidLoad()
    }
    
    private func createChatRoom(){
        let chatRoom = ChatRoom()
        chatRoom.members = "Test"
        dataSource.add(room: chatRoom)
    }
    
    @IBAction private func tappedAdd(_ sender: Any) {
        createChatRoom()
    }
    
    @IBAction func tappedLogOut(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        SyncUser.logOutAllUsers()
        hideShowViews(isLoggedIn: false)
    }
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet fileprivate weak var tableView: UITableView!
    fileprivate var dataSource = ChatRoomsStore()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isLoggedIn = SyncUser.currentUserLoggedIn
        hideShowViews(isLoggedIn: isLoggedIn)
    }
    
    private func hideShowViews(isLoggedIn: Bool){
        loginButton.isHidden = isLoggedIn
        tableView.isHidden = !isLoggedIn
        logOutButton.isEnabled = isLoggedIn
    }
}

extension ChatRoomsViewController: StoreListener{
    func storeUpdated() {
        tableView.reloadData()
    }
}

extension ChatRoomsViewController: UITableViewDelegate{
    
    func tableView(_ _: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let viewController = UIStoryboard.viewController(id: "ChatRoomViewController") as? ChatRoomViewController
            else { return }
        let room = dataSource.room(at: indexPath.row)
        let store = MessageStore(with: room)
        store.listener = viewController
        viewController.messageStore = store
        navigationController?.pushViewController(viewController, animated: true)
    }
}

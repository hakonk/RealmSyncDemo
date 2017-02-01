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
    
    override func viewDidLoad() {
        tableView.dataSource = self.dataSource
        tableView.delegate = self
        super.viewDidLoad()
    }
    
    //TODO: Invoke from button tap
    private func createChatRoom(){
        let chatRoom = ChatRoom()
        chatRoom.members = "Test"
        let realm = try! Realm()
        try! realm.write {
            realm.add(chatRoom)
        }
    }

    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    fileprivate var dataSource = ChatRoomDataSource()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginButton.isHidden = User.isLoggedIn
        tableView.isHidden = !User.isLoggedIn
        dataSource.fetchObjects()
        tableView.reloadData()
    }
}
extension ChatRoomsViewController: UITableViewDelegate{
    
    func tableView(_ _: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = UIStoryboard.viewController(id: "ChatRoomViewController") as? ChatRoomViewController else { return }
        viewController.chatRoom = dataSource.room(at: indexPath.row)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

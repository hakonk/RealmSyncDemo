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
        super.viewDidLoad()
        User.logOutAllUsers()
    }

    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource = ChatRoomDataSource()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginButton.isHidden = User.isLoggedIn
        tableView.isHidden = !User.isLoggedIn
    }

    
}


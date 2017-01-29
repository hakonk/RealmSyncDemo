//
//  ViewController.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 29/01/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import UIKit

struct UserState{
    static var isLoggedIn: Bool{
        return false
    }
}

final class ChatRoomsViewController: UIViewController {

    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginButton.isHidden = UserState.isLoggedIn
        tableView.isHidden = !UserState.isLoggedIn
    }

    
}


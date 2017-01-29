//
//  ViewController.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 29/01/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import UIKit
import RealmSwift

struct UserState{
    static var isLoggedIn: Bool{
        for (_, user) in SyncUser.__allUsers(){
            switch user.state{
            case .active:
                return true
            default: break
            }
        }
        return false
    }
}

final class ChatRoomsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (_, user) in SyncUser.__allUsers(){
            user.logOut()
        }
    }

    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginButton.isHidden = UserState.isLoggedIn
        tableView.isHidden = !UserState.isLoggedIn
    }

    
}


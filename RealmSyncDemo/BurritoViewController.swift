//
//  ViewController.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 29/01/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import UIKit
import RealmSwift

class BurritoViewController: UIViewController {
    
    var burritos: Results<Burrito>? {
        willSet{
            token?.stop()
        }
        didSet{
            token = burritos?.addNotificationBlock{ [weak self] (changes) in
                switch changes{
                case .initial:
                    self?.tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    self?.tableView.beginUpdates()
                    self?.tableView.deleteRows(at: deletions.map{ IndexPath(row: $0, section: 0) }, with: .automatic)
                    self?.tableView.insertRows(at: insertions.map{ IndexPath(row: $0, section: 0) }, with: .automatic)
                    self?.tableView.reloadRows(at: modifications.map{ IndexPath(row: $0, section: 0) }, with: .automatic)
                    self?.tableView.endUpdates()
                case .error(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    var token: NotificationToken?
    private var notifationObserver: NSObjectProtocol?
    
    deinit{
        token?.stop()
        guard let notifationObserver = self.notifationObserver else { return }
        NotificationCenter.default.removeObserver(notifationObserver)
    }
    
    fileprivate func deleteBurrito(at index: Int){
        let realm = try! Realm()
        try! realm.write {
            guard let object = burritos?[index] else { return }
            realm.delete(object)
        }
    }
    
    private func addBurrito(){
        let realm = try! Realm()
        try! realm.write {
            let burrito = BurritoHelper.new()
            realm.add(burrito)
        }
    }
    
    private func addListener(){
        notifationObserver = NotificationCenter
            .default
            .addObserver(forName: Notification.Name(rawValue: "loggedIn"), object: nil, queue: .main) {
                [weak self] _ in
                self?.burritos = try! Realm().objects(Burrito.self).sorted(byKeyPath: "date", ascending: false)
        }
    }
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        addListener()
        title = "Burritos"
        super.viewDidLoad()
    }
    
    @IBAction func tappedEdit(_ button: UIButton) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        button.isSelected = tableView.isEditing
    }
    
    
    @IBAction private func tappedAdd(_ sender: Any) {
        addBurrito()
    }
    
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet fileprivate weak var tableView: UITableView!
    
}

extension BurritoViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return burritos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = burritos?[indexPath.row].name
        return cell
    }
}


extension BurritoViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteBurrito(at: indexPath.row)
        }
    }
}

//
//  ViewController.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 29/01/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import UIKit
import RealmSwift

class Burrito: Object{
    dynamic var name = ""
    dynamic var date = Date()
}

struct BurritoHelper{
    static let types = ["Juarez", "Poncho", "Mission", "Carne Asada", "Chimichanga", "Hapa", "Breakfast"]
    static func new() -> Burrito{
        let burrito = Burrito()
        burrito.name = types[Int(arc4random() % UInt32(types.count))]
        return burrito
    }
}

class BurritoViewController: UIViewController {
    
    @IBOutlet private weak var logOutButton: UIBarButtonItem!
    
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
    
    deinit{
        token?.stop()
    }
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "loggedIn"), object: nil, queue: .main) { [weak self] _ in
            self?.burritos = try! Realm().objects(Burrito.self).sorted(byKeyPath: "date", ascending: false)
        }
        title = "Burritos"
        super.viewDidLoad()
    }
    
    @IBAction func tappedEdit(_ button: UIButton) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        button.isSelected = tableView.isEditing
    }
    private func addBurrito(){
        let realm = try! Realm()
        try! realm.write {  
            let burrito = BurritoHelper.new()
            realm.add(burrito)
        }
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
            let realm = try! Realm()
            try! realm.write {
                guard let object = burritos?[indexPath.row] else { return }
                realm.delete(object)
            }
        }
    }
}

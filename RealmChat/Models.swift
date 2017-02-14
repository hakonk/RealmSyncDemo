//
//  ChatMessage.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 31/01/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import Foundation
import RealmSwift

struct ModelUtil{
    static var modelTypes: [Object.Type]{
        return [SomeModel.self]
    }
}

class ChatRoomMember: Object{
    dynamic var userId: String = ""
    
    override static func primaryKey() -> String? {
        return "userId"
    }
}

class ChatMessage: Object {
    
    dynamic var messageId: String = UUID().uuidString
    dynamic var userId:  String = ""
    
    dynamic var text: String = ""
    
    dynamic var imageData: NSData?
    dynamic var timestamp: Date = Date()
    
    var someComputedProperty: String{
        return "\(userId): \(text)"
    }
    // Object subclasses
    var chatRoom: ChatRoom?
    var author: ChatRoomMember?
    
    required convenience init(text: String, chatRoom: ChatRoom) {
        self.init()
        self.text = text
        self.chatRoom = chatRoom
    }
    
    override static func ignoredProperties() -> [String] {
        return ["someComputedProperty"]
    }
    
    override static func primaryKey() -> String? {
        return "messageId"
    }
}

class SomeModel: Object{
    
    dynamic var id: String = UUID().uuidString
    dynamic var text: String = ""
    
    override static func primaryKey() -> String?{
        return "id"
    }
}

func update(){
    let realm = try! Realm()
    let model = realm.objects(SomeModel.self).first
    try! realm.write {
        model?.text = "New value"
    }
}

func deleteObject(){
    let realm = try! Realm()
    let object = realm.object(ofType: SomeModel.self, forPrimaryKey: "SomeKey")
    try! realm.write {
        realm.delete(object!)
    }
}

class ChatRoom: Object{
    
    dynamic var id = UUID().uuidString
    let messages = List<ChatMessage>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

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
        return [ChatMessage.self, ChatRoom.self]
    }
}

final class ChatMessage: Object {
    dynamic var text = ""
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
}

final class ChatRoom: Object{
    dynamic var members = ""
    
    dynamic var id = UUID().uuidString
    var messages = List<ChatMessage>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

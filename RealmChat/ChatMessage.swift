//
//  ChatMessage.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 31/01/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import Foundation
import RealmSwift

final class ChatMessage: Object {
    dynamic var text = ""
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
}

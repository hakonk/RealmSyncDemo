//
//  Burrito.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 15/02/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import Foundation
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

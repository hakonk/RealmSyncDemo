//
//  ErrorConvenience.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 29/01/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import Foundation

protocol ErrorConvenience{
    var error: NSError { get }
}

extension NSError{
    var improvedError: String{
        if let description = userInfo[NSLocalizedDescriptionKey] as? String{
            return "\(domain): " + "\(code) - " + description
        }
        return ""
    }
}

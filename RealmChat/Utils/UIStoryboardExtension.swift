//
//  UIStoryboardExtension.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 01/02/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard{
    
    static func viewController(id: String) -> UIViewController?{
        return UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: id)
    }
}

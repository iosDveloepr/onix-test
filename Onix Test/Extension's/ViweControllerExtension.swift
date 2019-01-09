//
//  ViweControllerExtension.swift
//  Onix Test
//
//  Created by Yermakov Anton on 1/7/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import UIKit

extension UIViewController{
    
    var contentViewcontroller: UIViewController{
        if let navcon = self as? UINavigationController{
            return navcon.visibleViewController!
        } else {
            return self
        }
    }
}

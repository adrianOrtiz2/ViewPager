//
//  Page.swift
//  PageViewController
//
//  Created by Adrian Ortiz on 1/19/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import UIKit

struct Page {
    
    let tab: Tab
    let viewController: UIViewController
    
}

extension Page {
    
    init(withViewController controller:UIViewController, name: String) {
        self.viewController = controller
        self.tab = Tab(withName: name)
    }
    
    init(withViewController controller:UIViewController, name: String, icon: String) {
        self.viewController = controller
        self.tab = Tab(withName: name, icon: icon)
    }
    
}

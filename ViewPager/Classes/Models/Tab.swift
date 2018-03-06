//
//  Tab.swift
//  PageViewController
//
//  Created by Adrian Ortiz on 1/19/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import Foundation

struct Tab {
    
    enum Animation {
        case none
        case swipe
    }
    
    enum LineType {
        case line
        case dot
    }
    
    var name:String
    var icon:String
    var animation: Animation
    var type: LineType
    
}

extension Tab {
    init(withName name: String) {
        self.name = name
        self.animation = .none
        self.icon = "line"
        self.type = .line
    }
    
    init(withName name: String, icon: String) {
        self.name = name
        self.animation = .none
        self.icon = icon
        self.type = .line
    }
}

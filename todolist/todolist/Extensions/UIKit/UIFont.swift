//
//  UIFont.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 10.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

extension UIFont {
    
    static public func `default`() -> UIFont {
        return UIFont(name:"Helvetica", size: 19)!
    }

    static public func bold() -> UIFont {
        return UIFont(name:"Helvetica-Bold", size: 18)!
    }

    static public func light() -> UIFont {
        return UIFont(name:"Helvetica-Light", size: 18)!
    }
}

//
//  NSObject.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 08.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

extension NSObject {
    static var identifier: String{
        return String(describing: self)
    }
}

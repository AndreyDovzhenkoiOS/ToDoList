//
//  TaskDate.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 17.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

final class TaskDate: NSObject {
    
    //MARK: - Public properties
    
    public let type: TaskDateKey?
    public var tasks: [Task]
    public var isSelect: Bool
    
    //MARK: - Initialization
    
    public init(type: TaskDateKey?, tasks: [Task]) {
        self.type = type
        self.tasks = tasks
        self.isSelect = true
    }
    
    public func selected(completion: @escaping VoidCallback) {
        isSelect.toggle()
        completion()
    }
}

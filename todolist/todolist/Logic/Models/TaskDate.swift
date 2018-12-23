//
//  TaskDate.swift
//  ToDoList
//
//  Created by Andrey on 17.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

final class TaskDate: NSObject {
    
    //MARK: - Public property
    
    let type: TaskDateKey?
    var tasks: [Task]
    var isSelect: Bool
    
    //MARK: - Initialization
    
    init(type: TaskDateKey?, tasks: [Task]) {
        self.type = type
        self.tasks = tasks
        self.isSelect = true
    }
}

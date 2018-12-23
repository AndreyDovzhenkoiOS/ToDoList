//
//  CompletedDelegate.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 16.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

protocol CompletedDelegate: class {
    func completed(_ task: Task, for type: TaskDateKey?)
}

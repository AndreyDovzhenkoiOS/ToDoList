//
//  NewTask.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 08.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class NewTask: NSObject {

    //MARK: - Public property

    var name: String?
    var important: Bool
    var personal: Bool
    var urgent: Bool
    var date: Date?
    var time: Date?

    let isTask: Bool
    let completed: Bool
    
    //MARK: - Initialization
    
    init(with task: Task?) {
        name = task?.name

        important = task?.important ?? false
        personal = task?.personal ?? false
        urgent = task?.urgent ?? false
        completed = task?.completed ?? false

        date = task?.date
        time = task?.time

        isTask = task != nil
    }
}

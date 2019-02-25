//
//  NewTask.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 08.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class NewTask: NSObject {
    
    //MARK: - Public properties
    
    public var name: String?
    public var important: Bool
    public var personal: Bool
    public var urgent: Bool
    public var date: Date?
    public var time: Date?
    
    public let isTask: Bool
    public let completed: Bool
    
    //MARK: - Initialization
    
    public init(with task: Task?) {
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

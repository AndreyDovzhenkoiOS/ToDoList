//
//  TaskDateManager.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 17.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

struct TaskDateManager {
    
    //MARK: - Public property
    
    static public var taskDates: [TaskDate] = []
    
    //MARK: - Public functions

    static public func taskDates(with tasks: [Task], modelItem: ModelItem?) -> [TaskDate] {
        
        guard let modelItem = modelItem,
            modelItem.type != ModelItemType.completed,
            modelItem.type != ModelItemType.overdue
            else {
                return [TaskDate(type: .none, tasks: tasks)]
        }

        taskDates.forEach {
            switch $0.type {
            case .overdue?:
                $0.tasks = overdueDate(for: tasks)
            case .today?:
                $0.tasks = todayDate(for: tasks)
            case .tomorrow?:
                $0.tasks = tomorrowDate(for: tasks)
            case .sevenDay?:
                $0.tasks = sevenDayDate(for: tasks)
            case .none: break
            }
        }
        
        return taskDates
    }
    
    //MARK: - Private functions
    
    //Filtered dates
    
    static private func overdueDate(for tasks: [Task]) -> [Task] {
        return tasks.filter { $0.date ?? Date() < Date() }
    }
    
    static private func todayDate(for tasks: [Task]) -> [Task] {
        return tasks.filter {
            let dateTask = String.dateToString($0.date ?? Date())
            let today = String.dateToString(Date())
            return dateTask == today && $0.date ?? Date() > Date()
        }
    }
    
    static private func tomorrowDate(for tasks: [Task]) -> [Task] {
        return tasks.filter {
            let dateTask = String.dateToString($0.date ?? Date())
            let toMorrow = String.dateToString(Date().addingTimeInterval(60*60*24))
            return dateTask == toMorrow
        }
    }
    
    static private func sevenDayDate(for tasks: [Task]) -> [Task] {
        return tasks.filter {
            let twoDay = Date().addingTimeInterval(60*60*24*2)
            let nineDay = Date().addingTimeInterval(60*60*24*9)
            let dateTask = $0.date ?? Date()
            return dateTask >= twoDay && dateTask <= nineDay
        }
    }
}

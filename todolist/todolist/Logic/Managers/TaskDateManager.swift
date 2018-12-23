//
//  TaskDateManager.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 17.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

struct TaskDateManager {
    
    // MARK: - Public property
    
    static var taskDates: [TaskDate] = []

    // MARK: - Public functions
    
    static func setselect(_ taskDate: TaskDate, completion: @escaping VoidCallback) {
        taskDate.isSelect.toggle()
        completion()
    }
    
    static func taskDates(with tasks: [Task], modelItem: ModelItem?) -> [TaskDate] {
        
        guard let modelItem = modelItem,
            modelItem.type != ModelItemProperty.ModelItemType.completed else {
                return [TaskDate(type: nil, tasks: tasks)]
        }
        
        guard  modelItem.type != ModelItemProperty.ModelItemType.overdue  else {
            return [TaskDate(type: .overdue, tasks: tasks)]
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
    
    // MARK: - Public functions

    // Filtered dates
    
    static func overdueDate(for tasks: [Task]) -> [Task] {
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

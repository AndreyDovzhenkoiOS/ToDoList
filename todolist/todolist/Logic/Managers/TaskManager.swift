//
//  TaskManager.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 16.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

struct TaskManager {
    
    // MARK: - Public functions
    
    static func sameTask(value: String) -> [Task] {
        let predicate = sameTaskPredicate(value: value)
        return DatabaseManager.shared.getFromDatabase(for: Task.identifier,
                                                      predicate: predicate) as! [Task]
    }
    
    static func filteredTasks(with modelItem: ModelItem) -> [Task] {
        let predicate = TaskManager.predicate(modelItem)
        let tasks = DatabaseManager.shared.getFromDatabase(for: Task.identifier,
                                                           predicate: predicate) as! [Task]
        switch modelItem.type {
        case .overdue:
            return orderedDate(for: tasks, with: .orderedAscending)
        default:
            return orderedDate(for: tasks, with: .orderedDescending)
        }
    }
    
    // MARK: - Private functions
    
    static private func orderedDate(for tasks: [Task],
                                    with comparisonResult: ComparisonResult ) -> [Task] {
        return tasks.sorted(by: { $0.date?.compare($1.date ?? Date()) == comparisonResult })
    }
    
    static private func predicate(_ modelItem: ModelItem) -> NSPredicate {
        switch modelItem.type {
        case .current:
            return currentPredicate()
        case .overdue:
            return overdueTaskPredicate()
        case .completed:
            return completedPredicate(key: modelItem.type.rawValue, isCompleted: true)
        default:
            return completedPredicate(key: modelItem.type.rawValue, isCompleted: false)
        }
    }
    
    static private func sameTaskPredicate(value: String) -> NSPredicate {
        return NSPredicate(format: Constants.Key.name.rawValue + " = %@", value)
    }

    static private func currentPredicate() -> NSPredicate {
        return NSPredicate(format:  Constants.Key.completed.rawValue + " = %@", NSNumber(value: false))
    }
    
    static private func overdueTaskPredicate() -> NSPredicate {
        let predicate = NSPredicate(format: Constants.Key.date.rawValue + " < %@", NSDate())
        let noCompletedPredicate = NSPredicate(format: Constants.Key.completed.rawValue + " = %@", NSNumber(value: false))
        return NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicate, noCompletedPredicate])
    }
    
    static private func completedPredicate(key: String, isCompleted: Bool) -> NSPredicate {
        let predicate = NSPredicate(format: key + " = %@", NSNumber(value: true))
        let completedPredicate = NSPredicate(format: Constants.Key.completed.rawValue + " = %@", NSNumber(value: isCompleted))
        return NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicate, completedPredicate])
    }
}

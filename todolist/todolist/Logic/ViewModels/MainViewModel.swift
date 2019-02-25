//
//  MainViewModel.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 06.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class MainViewModel: NSObject {
    
    //MARK: - Public properties
    
    public var taskDates: [TaskDate] = []
    public var modelItem: ModelItem?
    public var completionHandler = { (_: IndexPath, _ : Bool) -> Void in }
    
    //MARK: - Initializers
    
    public func installationTasks() {
        taskDates = TaskDateManager.taskDates(with: tasks(modelItem),
                                              modelItem: modelItem)
    }
    
    public func installationSelectedModelItem() {
        modelItem = ModelItemManager.selectModelItem()
    }
    
    //MARK: - Public functions
    
    public func deleteTask(indexPath: IndexPath) {
        let tuple = objects(indexPath: indexPath)
        DatabaseManager.shared.removeFromDatabase(with: tuple.task)
        refreshTaskDates(indexPath: indexPath)
    }
    
    public func selectedCompleted(for task: Task, type: TaskDateKey?) {
        guard let section = taskDates.index(where: { $0.type == type }) else { return }
        guard let row = taskDates[section].tasks.index(where: { $0 == task }) else { return }
        DatabaseManager.shared.saveContext()
        refreshTaskDates(indexPath: IndexPath(row: row, section: section))
    }
    
    public func objects(indexPath: IndexPath) -> (taskDate: TaskDate, task: Task) {
        let taskDate = taskDates[indexPath.section]
        let task = taskDate.tasks[indexPath.row]
        return (taskDate, task)
    }
    
    public func noTasks() -> Bool {
        return !taskDates.filter { !$0.tasks.isEmpty }.isEmpty
    }
    
    //MARK: - Private function
    
    private func tasks(_ modelItem: ModelItem?) -> [Task] {
        guard let modelItem = modelItem else { return [Task]() }
        return TaskManager.filteredTasks(with: modelItem)
    }
    
    private func refreshTaskDates(indexPath: IndexPath) {
        taskDates = TaskDateManager.taskDates(with: tasks(modelItem),
                                              modelItem: modelItem)
        let isEmpty = taskDates[indexPath.section].tasks.isEmpty
        completionHandler(indexPath, isEmpty)
    }
}

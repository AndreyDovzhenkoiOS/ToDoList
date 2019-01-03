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
    
    var taskDates: [TaskDate] = []
    var modelItem: ModelItem?
    var completionHandler = { (_: IndexPath, _ : Bool) -> () in }
    
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
        taskDates = TaskDateManager.taskDates(with: tasks(modelItem),
                                              modelItem: modelItem)
        completionHandler(indexPath, taskDates[indexPath.section].tasks.isEmpty)
    }
    
    public func selectedCompleted(for task: Task, type: TaskDateKey?) {
        guard let section = taskDates.index(where: { $0.type == type }) else { return }
        guard let row = taskDates[section].tasks.index(where: { $0 == task }) else { return }
        DatabaseManager.shared.saveContext()
        taskDates = TaskDateManager.taskDates(with: tasks(modelItem),
                                              modelItem: modelItem)
        completionHandler(IndexPath(row: row, section: section),
                          taskDates[section].tasks.isEmpty)
    }
    
    public func objects(indexPath: IndexPath) -> (taskDate: TaskDate, task: Task) {
        let taskDate = taskDates[indexPath.section]
        let task = taskDate.tasks[indexPath.row]
        return (taskDate, task)
    }

    //MARK: - Private function
    
    private func tasks(_ modelItem: ModelItem?) -> [Task] {
        guard let modelItem = modelItem else { return [Task]() }
        return TaskManager.filteredTasks(with: modelItem)
    }
}

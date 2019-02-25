//
//  SettingTaskViewModel.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 06.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class SettingTaskViewModel: NSObject {
    
    //MARK: - Property
    
    public var task: Task?
    public var newTask: NewTask!
    public var modelCells: [ModelCell] = []
    public var completionHandler = { (_: Bool) -> Void in }
    public var saveHandler = { (_: Bool, _: Bool) -> Void in }
    
    //MARK: - Initialization
    
    override init() { super.init()
        modelCells = Loader.modelCells()
    }
    
    public func setTask(task: Task?) {
        self.task = task
        newTask = NewTask(with: task)
    }
    
    //MARK: - Public functions
    
    public func save()  {
        let isFillAllFields = NewTaskManager.isFillAllFields(for: newTask)
        guard isFillAllFields.allFields else {
            completionHandler(isFillAllFields.isEmptyName)
            return
        }
        
        checkSameTask()
    }
    
    public func saveNewTask() {
        let date = NewTaskManager.allDate(with: newTask)
        let propertys: [String : Any?] = [Constants.Key.name.rawValue: newTask.name,
                                          Constants.Key.important.rawValue: newTask.important,
                                          Constants.Key.personal.rawValue: newTask.personal,
                                          Constants.Key.urgent.rawValue: newTask.urgent,
                                          Constants.Key.date.rawValue: date,
                                          Constants.Key.time.rawValue: newTask.time,
                                          Constants.Key.completed.rawValue: newTask.completed]
        saveChanges(propertys: propertys)
    }
    
    public func selectModelItem(isSave: Bool) {
        guard !newTask.isTask else { return }
        ModelItemManager.selectDefault()
    }
    
    public func checkHeightForHeader(_ section: Int) -> Bool {
        let type = modelCells[section].type
        return type == SettingTaskCellType.date || type == SettingTaskCellType.important
    }
    
    public func isSelectDateOrTime(_ type: SettingTaskCellType) -> Bool {
        return type == SettingTaskCellType.date || type == SettingTaskCellType.time
    }
    
    //MARK: - Private function
    
    private func checkSameTask() {
        guard let name = newTask.name else { return }
        let tasks = TaskManager.sameTask(value: name)
        if let taskName = task?.name, taskName == name {
            saveHandler(taskName == name, true)
        } else {
            saveHandler(tasks.isEmpty, false)
        }
    }

    private func saveChanges(propertys: [String: Any?]) {
        if let task = task {
            DatabaseManager.shared.setProperty(for: task, propertys: propertys)
        } else {
            DatabaseManager.shared.addToDatabase(for: Task.identifier, propertys: propertys)
        }
    }
}

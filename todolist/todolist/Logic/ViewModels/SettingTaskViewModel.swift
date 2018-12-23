//
//  SettingTaskViewModel.swift
//  ToDoList
//
//  Created by Anrey Dovzhenko on 06.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class SettingTaskViewModel: NSObject {
    
    //MARK: - Property
    
    var task: Task?
    var newTask: NewTask!
    var modelCells: [ModelCell] = []
    var completionHandler = { (_: Bool) -> () in }
    var saveHandler = { (_: Bool, _: Bool) -> () in }
    
    //MARK: - Initialization
    
    override init() { super.init()
        modelCells = Loader.modelCells()
    }
    
    public func setTask(task: Task?) {
        self.task = task
        newTask = NewTask(with: task)
    }
    
    // MARK: - Public functions
    
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
        changeSave(propertys: propertys)
        
    }
    
    public func changeSave(propertys: [String: Any?]) {
        if let task = task {
            DatabaseManager.shared.setProperty(for: task, propertys: propertys)
        } else {
            DatabaseManager.shared.addToDatabase(for: Task.identifier, propertys: propertys)
        }
    }
    
    public func selectModelItem(isSave: Bool) {
        guard !newTask.isTask else { return }
        ModelItemManager.selectDefault()
    }
    
    public func checkHeightForHeader(_ section: Int) -> Bool {
        let modelCell = modelCells[section]
        guard modelCell.type == SettingTaskCellType.date ||
            modelCell.type == SettingTaskCellType.important else { return false }
        return true
    }
    
    public func isSelectDateOrTime(_ type: SettingTaskCellType) -> Bool {
        guard type == SettingTaskCellType.date ||
            type == SettingTaskCellType.time else { return false }
        return true
    }

    // MARK: - Private functions
    
    private func checkSameTask() {
        guard let name = newTask.name else { return }
        let tasks = TaskManager.sameTask(value: name)
        if let taskName = task?.name, taskName == name {
            saveHandler(taskName == name, true)
        } else {
            saveHandler(tasks.isEmpty, false)
        }
    }
}

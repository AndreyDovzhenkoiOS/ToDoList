//
//  NewTaskManager.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 10.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

struct NewTaskManager {

    // MARK: - Public functions
    
    static func allDate(with newTask: NewTask) -> Date? {
        guard let date = newTask.date,
            let time = newTask.time else { return nil }
        let allDate = String.dateToString(date) + Constants.comma + String.timeToString(time)
        return String.stringToAllDate(allDate)
    }
    
    static func isEnabled(with newTask: NewTask) -> Bool {
        let statuses = [newTask.important, newTask.personal, newTask.urgent]
        return statuses.filter { $0 == false }.count == statuses.count
    }
    
    static func isFillAllFields(for newTask: NewTask) -> (allFields: Bool, isEmptyName: Bool) {
        guard let name = newTask.name else { return (false, false) }
        return (!name.isEmpty &&
                newTask.date != nil &&
                newTask.time != nil, !name.isEmpty)
    }
    
    static func setName(for newTask: NewTask, with name: String, string: String) {
        var text = name
        let isDelete = string == Constants.TextField.delete
        if isDelete {
            text.removeLast()
        } else {
            text += string
        }
        newTask.name = text.removingWhitespaces()
    }
    
    static func setSwitch(for newTask: NewTask, with type: SettingTaskCellType, isOn: Bool) {
        switch type {
        case .important:
            newTask.important = isOn
        case .personal:
            newTask.personal = isOn
        case .urgent:
            newTask.urgent = isOn
        default:
            return
        }
    }
}

//
//  Loader.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 09.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

struct Loader {
    
    //MARK: - Public functions
    
    static func loadingObjects() {
        ModelItemManager.modelItems = Loader.modelItems()
        TaskDateManager.taskDates = Loader.taskDates()
    }
    
    static func modelCells() -> [ModelCell] {
        var modelCells: [ModelCell] = []
        
        let identifiers = [NameTableViewCell.identifier,
                           StatusTableViewCell.identifier,
                           StatusTableViewCell.identifier,
                           StatusTableViewCell.identifier,
                           DateTableViewCell.identifier,
                           DateTableViewCell.identifier]
        let types = SettingTaskCellType.allCases
        
        for (index, value) in identifiers.enumerated() {
            let type = types[index]
            modelCells.append(ModelCell(title: type.rawValue,
                                        type: type,
                                        identifier: value,
                                        isEnabled: true))
        }
        
        return modelCells
    }
    
    //MARK: - Private functions
    
    static private func modelItems() -> [ModelItem] {
        var modelItems: [ModelItem] = []
        
        for index in 0..<ModelItemProperty.count {
            let name = ModelItemProperty.names[index].rawValue
            let type = ModelItemProperty.types[index]
            let image = UIImage(named: type.rawValue)
            
            let current = name == ModelItemProperty.ModelItemName.current.rawValue
            let isSelect = current ? true : false
            
            modelItems.append(ModelItem(name: name,
                                        type: type,
                                        image: image,
                                        isSelect: isSelect,
                                        number: nil))
        }
        
        return modelItems
    }
    
    static private func taskDates() -> [TaskDate] {
        var taskDates: [TaskDate] = []
        
        let types = TaskDateKey.allCases
        
        types.forEach {
            taskDates.append(TaskDate(type: $0, tasks: [Task]()))
        }
        
        return taskDates
    }
}

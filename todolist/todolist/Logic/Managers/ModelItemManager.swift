//
//  ModelItemManager.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 05.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

struct ModelItemManager {
    
    //MARK: - Public property
    
    static public var modelItems: [ModelItem] = []
    
    //MARK: - Public functions
    
    static public func selectModelItem() -> ModelItem? {
        return modelItems.filter { $0.isSelect == true }.first
    }
    
    static public func resetSelect() {
        modelItems.forEach { $0.isSelect = false }
    }
    
    static public func setupNumberTasks() {
        modelItems.forEach { $0.number = numberTask(for: $0) }
    }
    
    static public func setSelect(for modelItem: ModelItem) {
        resetSelect()
        modelItem.isSelect.toggle()
    }
    
    static public func selectDefault() {
        let current = ModelItemName.current.rawValue
        let modelItem = modelItems.filter { $0.name == current }.first
        guard let defaultModelItem = modelItem else { return }
        setSelect(for: defaultModelItem)
    }
    
    //MARK: - Private function
    
    static private func numberTask(for modelItem: ModelItem) -> Int? {
        guard modelItem.type != ModelItemType.newTask else { return nil }
        let tasks = TaskManager.filteredTasks(with: modelItem)
        return tasks.isEmpty ? nil : tasks.count
    }
}

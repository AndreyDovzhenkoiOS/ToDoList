//
//  ModelItemManager.swift
//  ToDoList
//
//  Created by Anrey Dovzhenko on 05.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

struct ModelItemManager {
    
    // MARK: - Public property
    
    static var modelItems: [ModelItem] = []
    
    // MARK: - Public functions
    
    static func selectModelItem() -> ModelItem? {
        return modelItems.filter { $0.isSelect == true }.first
    }
    
    static func resetSelect() {
        modelItems.forEach { $0.isSelect = false }
    }
    
    static func setupNumberTasks() {
        modelItems.forEach { $0.number = numberTask(for: $0) }
    }
    
    static func setSelect(for modelItem: ModelItem) {
        resetSelect()
        modelItem.isSelect.toggle()
    }
    
    static func selectDefault() {
        let current = ModelItemProperty.ModelItemName.current.rawValue
        let modelItem = modelItems.filter { $0.name == current }.first
        guard let defaultModelItem = modelItem else { return }
        setSelect(for: defaultModelItem)
    }
    
    // MARK: - Private functions
    
    static private func numberTask(for modelItem: ModelItem) -> Int? {
        guard modelItem.type != ModelItemProperty.ModelItemType.newTask else { return nil }
        let tasks = TaskManager.filteredTasks(with: modelItem)
        return tasks.isEmpty ? nil : tasks.count
    }
}

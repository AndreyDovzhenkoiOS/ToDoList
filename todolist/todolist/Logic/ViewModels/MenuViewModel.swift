//
//  MenuViewModel.swift
//  ToDoList
//
//  Created by Anrey Dovzhenko on 06.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class MenuViewModel: NSObject {
    
    // MARK: - Public Properties
    
    let modelItems: [ModelItem]
    var completionHandler = { (_ : Bool) -> () in }
    
    // MARK: - Initializers
    
    override init() {
        modelItems = ModelItemManager.modelItems
    }
    
    // MARK: - Public functions
    
    public func selectedModelItem(item: Int) {
        let modelItem = modelItems[item]
        guard !modelItem.isSelect else { return }
        ModelItemManager.setSelect(for: modelItem)
        completionHandler(modelItem.type == ModelItemProperty.ModelItemType.newTask)
    }
}

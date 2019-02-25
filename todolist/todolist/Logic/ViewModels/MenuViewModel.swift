//
//  MenuViewModel.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 06.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class MenuViewModel: NSObject {
    
    //MARK: - Public Properties
    
    public let modelItems: [ModelItem]
    public var completionHandler = { (_ : Bool) -> Void in }
    
    //MARK: - Initializers
    
    override init() {
        modelItems = ModelItemManager.modelItems
    }
    
    //MARK: - Public function
    
    public func selectedModelItem(item: Int) {
        let modelItem = modelItems[item]
        guard !modelItem.isSelect else { return }
        ModelItemManager.setSelect(for: modelItem)
        completionHandler(modelItem.type == ModelItemType.newTask)
    }
}

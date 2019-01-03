//
//  ModelItem.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 05.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

final class ModelItem: NSObject {

    //MARK: - Public properties
    
    let name: String
    let type: ModelItemProperty.ModelItemType
    let image: UIImage?

    var isSelect: Bool
    var number: Int?
    
    //MARK: - Initialization
    
    init(name: String,
         type: ModelItemProperty.ModelItemType,
         image: UIImage?,
         isSelect: Bool,
         number: Int?) {
        self.name = name
        self.type = type
        self.image = image
        self.isSelect = isSelect
        self.number = number
    }
}

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
    
    public let name: String
    public let type: ModelItemType
    public let image: UIImage?
    
    public var isSelect: Bool
    public var number: Int?
    
    //MARK: - Initialization
    
    public init(name: String,
                type: ModelItemType,
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

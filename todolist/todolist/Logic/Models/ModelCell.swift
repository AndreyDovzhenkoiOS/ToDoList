//
//  ModelCell.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 08.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

struct ModelCell {
    
    //MARK: - Public properties
    
    public let title: String
    public let type: SettingTaskCellType
    public let identifier: String
    public let isEnabled: Bool
    
    //MARK: - Public function
    
    public func updateModelCell(with isEnabled: Bool) -> ModelCell {
        return ModelCell(title: title,
                         type: type,
                         identifier: identifier,
                         isEnabled: isEnabled)
    }
}

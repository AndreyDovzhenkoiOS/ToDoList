//
//  ModelCell.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 08.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

struct ModelCell {

    //MARK: - Public property
    
    let title: String
    let type: SettingTaskCellType
    let identifier: String
    let isEnabled: Bool

    // MARK: - Public functions
    
    func updateModelCell(with isEnabled: Bool) -> ModelCell {
        return ModelCell(title: title,
                         type: type,
                         identifier: identifier,
                         isEnabled: isEnabled)
    }
}

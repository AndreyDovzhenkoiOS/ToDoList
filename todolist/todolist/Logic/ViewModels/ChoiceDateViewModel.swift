//
//  ChoiceDateViewModel.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 23.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class ChoiceDateViewModel: NSObject {
    
    //MARK: - Public properties
    
    public var newTask: NewTask?
    public var modelCell: ModelCell?
    public var completionHandler = { (_: ModelCell) -> Void in }
    
    //MARK: - Initialization
    
    static public func initilization(newTask: NewTask?, modelCell: ModelCell?) -> ChoiceDateViewModel {
        let viewModel = ChoiceDateViewModel()
        viewModel.newTask = newTask
        viewModel.modelCell = modelCell
        return viewModel
    }
    
    //MARK: - Public function
    
    public func saveDate(date: Date) {
        guard let modelCell = modelCell else { return }
        if modelCell.type == SettingTaskCellType.date {
            newTask?.date = date
        } else {
            newTask?.time = date
        }
        completionHandler(modelCell)
    }
}

//
//  StatusViewModel.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 15.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class StatusViewModel: NSObject {
    
    //MARK: - Public Properties
    
    public var completionHandler = { (modelCell: ModelCell) -> () in }
    
    //MARK: - Private Properties
    
    private var modelCell: ModelCell?
    
    //MARK: - Initialization
    
    private override init() { super.init()
        NotificationCenter.addObserver(self, #selector(update(_:)),
                                       NotificationName.notificationSettingStatus)
    }
    
    //MARK: - Public functions
    
    static public func initilization(modelCell: ModelCell?) -> StatusViewModel {
        let statusViewModel = StatusViewModel()
        statusViewModel.modelCell = modelCell
        return statusViewModel
    }
    
    public func statusSwitch(for newTask: NewTask, isOn: Bool) {
        guard let modelCell = modelCell else { return }
        NewTaskManager.setSwitch(for: newTask, with: modelCell.type, isOn: isOn)
        NotificationCenter.post(NotificationName.notificationSettingStatus,
                                modelCell.updateModelCell(with: isOn))
    }
    
    public func getSwitchStatus(with newTask: NewTask, type: SettingTaskCellType) -> Bool {
        switch type {
        case .important:
            return newTask.important
        case .personal:
            return newTask.personal
        case .urgent:
            return newTask.urgent
        default:
            return false
        }
    }
    
    //MARK: - Private function
    
    @objc private func update(_ sender: Notification) {
        guard let updateModelCell = sender.object as? ModelCell,
            let modelCell = modelCell else { return }
        if updateModelCell.type == modelCell.type && updateModelCell.isEnabled {
            completionHandler(updateModelCell)
        } else {
            completionHandler(modelCell.updateModelCell(with: !updateModelCell.isEnabled))
        }
    }
}

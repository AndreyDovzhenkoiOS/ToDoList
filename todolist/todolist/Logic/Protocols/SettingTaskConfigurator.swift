//
//  SettingTaskConfigurator.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 08.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

protocol SettingTaskConfigurator {
    var newTask: NewTask? { get set }
    var modelCell: ModelCell? { get set }

    func updateUI(_ modelCell: ModelCell)
    func initilization(newTask: NewTask?, modelCell: ModelCell)
}

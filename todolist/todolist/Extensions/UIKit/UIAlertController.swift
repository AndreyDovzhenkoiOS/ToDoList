//
//  UIAlertController.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 13.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

extension UIAlertController {
    
    static public func sameTask() -> UIAlertController {
        return alertController(message: Constants.Alert.sameTask,
                               titleAction: Constants.Alert.cancel)
    }
    
    static public func fillAllFields() -> UIAlertController {
        return alertController(message: Constants.Alert.fillAllFilds,
                               titleAction: Constants.Alert.exit)
    }
    
    static public func emptyNameTask() -> UIAlertController {
        return alertController(message: Constants.Alert.emptyNameTask,
                               titleAction: Constants.Alert.exit)
    }
    
    static public func cancel(completion: @escaping () -> ()) -> UIAlertController {
        
        let cancelAlertController = alertController(message: Constants.Alert.cancelTask,
                                                    titleAction: Constants.Alert.cancel)
        
        cancelAlertController.addAction(UIAlertAction(title: Constants.Alert.yes,
                                                      style: .destructive,
                                                      handler: { _ in completion() }))
        return cancelAlertController
    }
    
    static public func saveTask(isEdit: Bool, completion: @escaping () -> ()) -> UIAlertController {
        let message = isEdit ? Constants.Alert.editTask : Constants.Alert.saveTask
        let saveTaskAlertController = alertController(message: message,
                                                      titleAction: Constants.Alert.cancel)
        
        saveTaskAlertController.addAction(UIAlertAction(title: Constants.Alert.save,
                                                        style: .destructive,
                                                        handler: { _ in completion() }))
        return saveTaskAlertController
    }
    
    static fileprivate func alertController(message: String,
                                            titleAction: String) -> UIAlertController {
        
        let alertController = UIAlertController(title: Constants.Alert.title,
                                                message:message,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: titleAction, style: .default,
                                                handler: nil))
        return alertController
    }
}

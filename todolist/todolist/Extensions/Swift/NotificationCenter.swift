//
//  NotificationCenter.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 12.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

extension NotificationCenter {

    static public func post(_ name: Notification.Name, _ object: Any?) {
        NotificationCenter.default.post(name: name, object: object)
    }
    
    static public func addObserver(_ observer: Any,
                                   _ selector: Selector,
                                   _ name: Notification.Name) {

        NotificationCenter.default.addObserver(observer, selector: selector,
                                               name: name,
                                               object: nil)
    }
}

enum NotificationName {
    static let notificationSettingDate = Notification.Name(Constants.NotificationName.updateSettingDate)
    static let notificationSettingStatus = Notification.Name(Constants.NotificationName.updateSettingStatus)
    static let notificationMenuUpdate = Notification.Name(Constants.NotificationName.updateMenu)
    static let notificationMainUpdate = Notification.Name(Constants.NotificationName.updateMain)
}

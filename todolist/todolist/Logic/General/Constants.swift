//
//  Constants.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 05.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

enum Constants {
    static let viewController = "ViewController"
    static let delete = "Удалить"
    static let emptyTasks = "Задачи отсутствуют"
    static let today = "Сегодня" + comma
    static let tomorrow = "Завтра" + comma
    static let comma = ", "

    enum NotificationName {
        static let updateSettingDate = "notificationUpdateSettingDate"
        static let updateSettingStatus = "notificationUpdateSettingStatus"
        static let updateMenu = "notificationUpdateMenu"
        static let updateMain = "notificationUpdateMain"
    }

    enum Alert {
        static let yes = "Да"
        static let title = "Сообщение"
        static let cancel = "Отмена"
        static let exit = "Выход"
        static let save = "Сохранить"
        static let saveTask = "Вы действительно хотите сохранить новую задачу?"
        static let editTask = "Вы действительно хотите сохранить изменения?"
        static let emptyNameTask = "Название задачи не может быть пустым"
        static let cancelTask = "Вы действительно хотите отменить?\n Заполненные данные будут не сохранены!"
        static let sameTask = "Задача с таким названием уже существует!"
        static let fillAllFilds = "Заполните все поля!"
    }
    
    enum TextField {
        static let delete = ""
    }
    
    enum Key: String {
        case name
        case important
        case personal
        case urgent
        case date
        case time
        case completed
    }
    
    enum Title {
        static let myTask = "Мои задачи"
        static let newTask = "Новая задача"
        static let changeTask = "Редактирование"
    }
    
    enum Image: String {
        case filterUp
        case filterDown
        case separator
        case completedOn
        case completedOff
    }
}

enum TaskDateKey: String, CaseIterable {
    case overdue = "Просроченные"
    case today = "Сегодня"
    case tomorrow = "Завтра"
    case sevenDay = "Следующие 7 дней"
}

enum SettingTaskCellType: String, CaseIterable {
    case name
    case important = "Важное"
    case personal = "Личное"
    case urgent = "Срочное"
    case date = "Срок исполнения"
    case time = "Время"
}

enum ModelItemProperty {
    static let count = ModelItemName.allCases.count
    static let names = ModelItemName.allCases
    static let types = ModelItemType.allCases
    
    enum ModelItemName: String, CaseIterable {
        case newTask = "Добавить задачу"
        case current = "Текущие"
        case overdue = "Просроченные"
        case important = "Важные"
        case urgent = "Срочные"
        case personal = "Личные"
        case completed = "Выполненные"
    }
    
    enum ModelItemType: String, CaseIterable {
        case newTask, current, overdue, important,
        urgent, personal, completed
    }
}

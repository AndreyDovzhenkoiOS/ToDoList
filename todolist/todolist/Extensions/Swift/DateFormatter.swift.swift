//
//  DateFormatter.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 11.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static public var dateDateFormatt: DateFormatter {
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "dd.MM.yyyy"
        return dateFormatt
    }
    
    static public var timeDateFormatt: DateFormatter {
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "HH:mm"
        return dateFormatt
    }
    
    static public var allDateDateFormatt: DateFormatter {
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "dd.MM.yyyy, HH:mm"
        return dateFormatt
    }
}

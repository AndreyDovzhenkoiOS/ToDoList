//
//  Date.swift
//  ToDoList
//
//  Created by Andrey on 25.02.2019.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

extension Date {

    //MARK: - Convert Dates
    
    static public func stringToAllDate(_ string: String) -> Date {
        let formatter = DateFormatter.allDateDateFormatt
        return formatter.date(from: string)!
    }
    
    static public func stringToDate(_ string: String) -> Date {
        let formatter = DateFormatter.dateDateFormatt
        return formatter.date(from: string)!
    }
}

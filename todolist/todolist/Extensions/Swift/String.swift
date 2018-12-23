//
//  String.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 10.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

extension String {

    func size(font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }

    func removingWhitespaces() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    //MARK: - Convert Strings
    
    static func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter.dateDateFormatt
        return formatter.string(from: date)
    }
    
    static func timeToString(_ date: Date) -> String {
        let formatter = DateFormatter.timeDateFormatt
        return formatter.string(from: date)
    }
    
    static func allDateToString(_ date: Date) -> String {
        let formatter = DateFormatter.allDateDateFormatt
        return formatter.string(from: date)
    }

    //MARK: - Convert Dates

    static func stringToAllDate(_ string: String) -> Date {
        let formatter = DateFormatter.allDateDateFormatt
        return formatter.date(from: string)!
    }

    static func stringToDate(_ string: String) -> Date {
        let formatter = DateFormatter.dateDateFormatt
        return formatter.date(from: string)!
    }
}

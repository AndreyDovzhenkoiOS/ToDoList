//
//  String.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 10.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

extension String {
    
    public func size(font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
    
    public func removingWhitespaces() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    //MARK: - Convert Strings
    
    static public func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter.dateDateFormatt
        return formatter.string(from: date)
    }
    
    static public func timeToString(_ date: Date) -> String {
        let formatter = DateFormatter.timeDateFormatt
        return formatter.string(from: date)
    }
    
    static public func allDateToString(_ date: Date) -> String {
        let formatter = DateFormatter.allDateDateFormatt
        return formatter.string(from: date)
    }
}

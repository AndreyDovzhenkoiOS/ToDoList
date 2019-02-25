//
//  UITableView.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 10.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

extension UITableView {
    
    public func registerCell(_ identifier: String) {
        register(UINib(nibName: identifier, bundle: nil),
                 forCellReuseIdentifier: identifier)
    }
    
    public func settingSeparators() {
        separatorColor = .separator
        tableFooterView = UIView(frame: CGRect.zero)
    }
    
    public func reloadWithoutAnimation() {
        perform(#selector(updateData), with: nil, afterDelay: 0.2)
    }
    
    @objc private func updateData() {
        reloadData()
    }
}

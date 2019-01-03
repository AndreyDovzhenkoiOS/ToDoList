//
//  UITableView.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 10.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

extension UITableView {
    
    func registerCell(_ identifier: String) {
        register(UINib(nibName: identifier, bundle: nil),
                 forCellReuseIdentifier: identifier)
    }
    
    func settingSeparators() {
        separatorColor = .separator
        tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func reloadWithoutAnimation(){
        Timer.scheduledTimer(timeInterval: 0.2,
                             target: self,
                             selector: #selector(reloadData),
                             userInfo: nil, repeats: false)
    }
    
    @objc private func updateData() {
        reloadData()
    }
}

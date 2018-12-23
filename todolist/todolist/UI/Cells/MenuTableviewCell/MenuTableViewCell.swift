//
//  MenuTableViewCell.swift
//  ToDoList
//
//  Created by Anrey Dovzhenko on 05.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class MenuTableViewCell: BaseTableViewCell {
    
    //MARK: - IBOutlet
    
    @IBOutlet private weak var numberLabel: UILabel!
    
    // MARK: - Public functions
    
    public func updateUI(_ modelItem: ModelItem) {
        setupNumber(modelItem)
        setupTextLabel(modelItem)
        imageView?.image = modelItem.image
    }
    
    // MARK: - Private functions
    
    private func setupTextLabel(_ modelItem: ModelItem) {
        textLabel?.font = UIFont.default()
        textLabel?.text = modelItem.name
        textLabel?.textColor = modelItem.isSelect ? .default : .black
    }
    
    private func setupNumber(_ modelItem: ModelItem) {
        numberLabel.text = nil
        if let number = modelItem.number {
            numberLabel.text = String(number)
        }
    }
}

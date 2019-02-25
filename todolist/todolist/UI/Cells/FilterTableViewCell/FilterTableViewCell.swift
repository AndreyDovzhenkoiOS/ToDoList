//
//  FilterTableViewCell.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 17.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class FilterTableViewCell: BaseTableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var separatorView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var statusImageView: UIImageView!
    
    //MARK: - Public function
    
    public func updateUI(_ taskDate: TaskDate) {
        titleLabel?.text = taskDate.type?.rawValue
        statusImageView.isHidden = !taskDate.isSelect
        separatorView.isHidden = taskDate.type == TaskDateKey.sevenDay
    }
}

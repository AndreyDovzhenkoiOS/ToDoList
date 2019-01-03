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
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    
    //MARK: - Public function
    
    func updateUI(_ taskDate: TaskDate) {
        titleLabel?.text = taskDate.type?.rawValue
        setupSeparatorView(taskDate: taskDate)
        statusImageView.isHidden = !taskDate.isSelect
    }
    
    //MARK: - Private function
    
    private func setupSeparatorView(taskDate: TaskDate) {
        guard let type = taskDate.type else { return }
        separatorView.isHidden = type == TaskDateKey.sevenDay
    }
}

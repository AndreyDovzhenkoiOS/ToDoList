//
//  BaseTableViewCell.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 08.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    //MARK: - Initilization

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

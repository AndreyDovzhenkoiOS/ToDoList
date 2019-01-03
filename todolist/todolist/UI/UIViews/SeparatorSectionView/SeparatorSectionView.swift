//
//  SeparatorSectionView.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 14.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class SeparatorSectionView: UIView {

    //MARK: - IBOutlets
    
    @IBOutlet private weak var titlelabel: UILabel!
    @IBOutlet private weak var emptyTaskLabel: UILabel!

    //MARK: - Public property
    
    var taskDate: TaskDate? {
        didSet {
            guard let taskDate = taskDate else { return }
            updateUI(taskDate)
        }
    }
    
    //MARK: - Initilization
    
    static func initilization(taskDate: TaskDate?) -> SeparatorSectionView {
        var separatorSectionView = SeparatorSectionView()
        separatorSectionView = .fromNib()
        separatorSectionView.taskDate = taskDate
        return separatorSectionView
    }
    
    //MARK: - Private function
    
    private func updateUI(_ taskDate: TaskDate) {
        titlelabel.text = taskDate.type?.rawValue.uppercased()
        emptyTaskLabel.text = Constants.emptyTasks
        emptyTaskLabel.isHidden = !taskDate.tasks.isEmpty
    }
}

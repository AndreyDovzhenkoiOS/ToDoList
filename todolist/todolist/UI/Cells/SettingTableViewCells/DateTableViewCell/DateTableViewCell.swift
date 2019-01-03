//
//  DateTableViewCell.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 08.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class DateTableViewCell: BaseTableViewCell, SettingTaskConfigurator {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    //MARK: - Public properties
    
    public var newTask: NewTask?
    
    public var modelCell: ModelCell? {
        didSet {
            guard let modelCell = modelCell else { return }
            updateUI(modelCell)
        }
    }
    
    //MARK: - Initilization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
        NotificationCenter.addObserver(self, #selector(update(_:)),
                                       NotificationName.notificationSettingDate)
    }
    
    //MARK: - Public functions
    
    public func initilization(newTask: NewTask?, modelCell: ModelCell) {
        self.newTask = newTask
        self.modelCell = modelCell
    }

    @objc func update(_ sender: Notification) {
        guard let updateModelCell = sender.object as? ModelCell,
            let type = modelCell?.type else { return }
        guard updateModelCell.type != type else { updateUI(updateModelCell); return }
    }
    
    internal func updateUI(_ modelCell: ModelCell) {
        titleLabel.text = modelCell.title
        setupDateLabel()
    }
    
    //MARK: - Private function
    
    private func setupDateLabel() {
        guard let newTask = newTask,
            let type = modelCell?.type else { return }
        
        if type == SettingTaskCellType.date {
            guard let date = newTask.date else { return }
            dateLabel?.text = String.dateToString(date)
        } else {
            guard let time = newTask.time else { return }
            dateLabel?.text = String.timeToString(time)
        }
    }
}

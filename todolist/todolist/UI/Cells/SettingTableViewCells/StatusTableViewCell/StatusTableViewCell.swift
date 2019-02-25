//
//  StatusTableViewCell.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 08.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class StatusTableViewCell: BaseTableViewCell, SettingTaskConfigurator {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var switchStatus: UISwitch!
    
    //MARK: - Public properties
    
    public var newTask: NewTask?
    
    public var modelCell: ModelCell? {
        didSet {
            guard let modelCell = modelCell else { return }
            setupViewModel()
            updateUI(modelCell)
        }
    }
    
    //MARK: - Private property
    
    private var viewModel: StatusViewModel?
    
    //MARK: - IBAction
    
    @IBAction private func statusAction(_ sender: UISwitch) {
        guard let newTask = newTask else { return }
        viewModel?.statusSwitch(for: newTask, isOn: sender.isOn)
    }
    
    //MARK: - Public functions
    
    public func initilization(newTask: NewTask?, modelCell: ModelCell) {
        self.newTask = newTask
        self.modelCell = modelCell
    }
    
    internal func updateUI(_ modelCell: ModelCell) {
        titleLabel.text = modelCell.title
        setupSwitchStatus(with: modelCell)
    }
    
    //MARK: - Private functions
    
    private func setupViewModel() {
        viewModel = StatusViewModel.initilization(modelCell: modelCell)
        viewModel?.completionHandler = { [weak self] modelCell in
            self?.updateUI(modelCell)
        }
    }
    
    private func setupSwitchStatus(with modelCell: ModelCell) {
        guard let newTask = newTask, let viewModel = viewModel else { return }
        let status = viewModel.getSwitchStatus(with: newTask, type: modelCell.type)
        switchStatus.isOn = status
        switchStatus.transform = CGAffineTransform(scaleX: 0.95, y: 0.88)
        
        //Select only one of the status points.
        //setupSwitchStatusEnabled(modelCell.isEnabled, status: status)
    }
    
    private func setupSwitchStatusEnabled(_ isEnabled: Bool, status: Bool) {
        if let newTask = newTask, newTask.isTask, !status {
            switchStatus.isEnabled = NewTaskManager.isEnabled(with: newTask)
        } else {
            switchStatus.isEnabled = isEnabled
        }
    }
}

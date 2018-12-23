//
//  ChoiceDateViewController.swift
//  ToDoList
//
//  Created byAndrey Dovzhenko on 10.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class ChoiceDateViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var datePickerView: UIDatePicker!
    @IBOutlet private weak var saveButton: UIButton!
    
    // MARK: - Private functions
    
    private var viewModel: ChoiceDateViewModel?
    
    // MARK: - Initializers
    
    func initilization(newTask: NewTask?, modelCell: ModelCell) {
        viewModel = ChoiceDateViewModel.initilization(newTask: newTask,
                                                      modelCell: modelCell)
        completionHandlerViewModel()
        updateUI()
    }
    
    // MARK: - Public functions
    
    func completionHandlerViewModel() {
        viewModel?.completionHandler = {[weak self] modelCell in
            NotificationCenter.post(NotificationName.notificationSettingDate, modelCell)
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Private functions
    
    private func updateUI() {
        loadViewIfNeeded()
        settingDatePickerView(type: viewModel?.modelCell?.type)
        contentView.layer.cornerRadius = 8
        saveButton.roundCorners(corners: [.topLeft, .topRight], radius: 8)
    }
    
    // MARK: - IBActions
    
    @IBAction private func saveAction(_ sender: UIButton) {
        sender.animateSelect {
            self.viewModel?.saveDate(date: self.datePickerView.date)
        }
    }
    
    @IBAction private func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private functions
    
    private func settingDatePickerView(type: SettingTaskCellType?) {
        if type == SettingTaskCellType.date {
            datePickerView.datePickerMode = .date
            datePickerView.date = viewModel?.newTask?.date ?? Date()
        } else {
            datePickerView.datePickerMode = .time
            datePickerView.date = viewModel?.newTask?.time ?? Date()
        }
    }
}

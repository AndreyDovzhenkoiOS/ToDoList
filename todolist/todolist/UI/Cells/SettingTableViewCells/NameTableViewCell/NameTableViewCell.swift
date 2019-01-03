//
//  NameTableViewCell.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 08.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class NameTableViewCell: BaseTableViewCell, SettingTaskConfigurator {
    
    //MARK: - IBOutlet
    
    @IBOutlet private weak var textField: UITextField!
    
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
    }
    
    //MARK: - Public functions
    
    public func initilization(newTask: NewTask?, modelCell: ModelCell) {
        self.newTask = newTask
        self.modelCell = modelCell
    }
    
    internal func updateUI(_ modelCell: ModelCell) {
        guard let newTask = newTask, let name = newTask.name else { return }
        textField.text = name
    }
}

//MARK: - TextField

extension NameTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let text = textField.text, let newTask = newTask else { return false }
        NewTaskManager.setName(for: newTask, with: text, string: string)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}

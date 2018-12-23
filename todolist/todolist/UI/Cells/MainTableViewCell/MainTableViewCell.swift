//
//  MainTableViewCell.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 13.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class MainTableViewCell: BaseTableViewCell {
    
    //MARK: - IBOutlet
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var completedButton: UIButton!
    @IBOutlet private weak var statusDownImageView: UIImageView!
    @IBOutlet private weak var statusUpImageView: UIImageView!
    
    // MARK: - Private property
    
    weak private var delegate: CompletedDelegate?
    private var type: TaskDateKey?
    
    private var task: Task? {
        didSet {
            guard let task = task else { return }
            updateUI(task)
        }
    }
    
    //MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
    }
    
    public func initilization(delagate: CompletedDelegate?, task: Task?, type: TaskDateKey?) {
        self.delegate = delagate
        self.type = type
        self.task = task
    }
    
    //MARK: - IBAction
    
    @IBAction private func completedAction(_ sender: UIButton) {
        selectedCompleted()
    }
    
    // MARK: - Private functions
    
    private func updateUI(_ task: Task) {
        statusDownImageView.isHidden = !task.urgent
        statusUpImageView.isHidden = !task.personal
        
        titleLabel.text = task.name
        titleLabel.font = task.important ? .bold() : .light()
        
        setupDateLabel(date: task.date)
        
        completedButton.setImage(selectedImage(task: task), for: .normal)
    }
    
    private func setupDateLabel(date: Date?) {
        guard let date = date else { return }
        setTextDateLabel(date: date)
        setTextColorDateLablel()
    }
    
    private func setTextDateLabel(date: Date) {
        switch type {
        case .today?:
            dateLabel.text = Constants.today + String.timeToString(date)
        case .tomorrow?:
            dateLabel.text = Constants.tomorrow + String.timeToString(date)
        default:
            dateLabel.text = String.allDateToString(date)
        }
    }
    
    private func setTextColorDateLablel(){
        guard let type = type else { return }
        let isOverdue = type == TaskDateKey.overdue
        dateLabel.textColor = isOverdue ? .textRedColor : .textDefaultColor
    }
    
    private func selectedCompleted() {
        guard let task = task else { return }
        task.completed.toggle()
        updateUI(task)
        delegate?.completed(task, for: type)
    }
    
    private func selectedImage(task: Task) -> UIImage? {
        if task.completed {
            return UIImage(named: Constants.Image.completedOn.rawValue)
        } else {
            return UIImage(named: Constants.Image.completedOff.rawValue)
        }
    }
}

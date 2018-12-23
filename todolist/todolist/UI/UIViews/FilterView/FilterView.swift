//
//  tralala.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 17.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class FilterView: UIView {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Public property
    
    var taskDates: [TaskDate] = []
    
    // MARK: - Initilization
    
    static func initilization(navigationFrame: CGRect, taskDates: [TaskDate]) -> FilterView {
        var filterView = FilterView()
        filterView = .fromNib()
        filterView.frame = CGRect(origin: CGPoint(x: navigationFrame.origin.x,
                                                  y: navigationFrame.height),
                                  size: CGSize(width: navigationFrame.width,
                                               height: 0))
        filterView.taskDates = taskDates

        return filterView
    }
    
    override func awakeFromNib() {
        tableView.registerCell(FilterTableViewCell.identifier)
    }

    // MARK: - Public functions
    
    func showFilterView(isSelected: Bool, height: CGFloat) {
        if isSelected {
            hiddenFilterView(height: height, isHidden: !isSelected)
        } else {
            hiddenFilterView(height: 0, isHidden: isSelected)
        }
    }
    
    // MARK: - Private functions
    
    private func hiddenFilterView(height: CGFloat, isHidden: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame.size.height = height
            self.tableView.frame.size.height = height
        }) { _ in
            guard isHidden else { return }
            self.removeFromSuperview()
        }
    }
}

//MARK: - UITableView

extension FilterView: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier) as!FilterTableViewCell
        cell.updateUI(taskDates[indexPath.row])
        return cell
    }
    
    //MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TaskDateManager.setselect(taskDates[indexPath.row]) {
            tableView.reloadData()
            NotificationCenter.post(NotificationName.notificationMainUpdate, nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.2
    }
}

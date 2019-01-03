//
//  MainViewController.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 05.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class MainViewController: BaseViewController {

    //MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private property
    
    private let viewModel = MainViewModel()
    
    //MARK: - Initilization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView()
        setupNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defaultSetting()
    }
    
    //MARK: - Private functions
    
    private func defaultSetting() {
        settingViewModel()
        setupFilterButton()
        setupMenu(install: true)
        tableView.reloadData()
    }
    
    private func settingViewModel() {
        viewModel.installationSelectedModelItem()
        viewModel.installationTasks()
        viewModelCompletionHandler()
    }
    
    private func settingTableView() {
        tableView.registerCell(MainTableViewCell.identifier)
        tableView.settingSeparators()
    }
    
    private func viewModelCompletionHandler() {
        viewModel.completionHandler = { [weak self] indexPath, isEmptyTasks in
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            NotificationCenter.post(NotificationName.notificationMenuUpdate, nil)
            guard !isEmptyTasks else {
                self?.tableView.reloadWithoutAnimation()
                return
            }
        }
    }
    
    private func setupFilterButton() {
        guard let modelItem = viewModel.modelItem else { return }
        guard modelItem.type !=  ModelItemType.completed,
            modelItem.type != ModelItemType.overdue else {
            setTitle(string: modelItem.name); return
        }
        installationFilter(tasksDates: viewModel.taskDates,
                           title: modelItem.name)
    }
    
    private func setupNotification()  {
        NotificationCenter.addObserver(self, #selector(update(_:)),
                                       NotificationName.notificationMainUpdate)
    }
    
    @objc private func update(_ sender: Notification) {
        tableView.reloadData()
    }
}

//MARK: - UITableView

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.taskDates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let taskDate = viewModel.taskDates[section]
        return taskDate.isSelect ? taskDate.tasks.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as! MainTableViewCell
        let tuple = viewModel.objects(indexPath: indexPath)
        cell.initilization(delagate: self,
                           task: tuple.task,
                           type: tuple.taskDate.type)
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskDate = viewModel.taskDates[indexPath.section]
        transitionSettingTaskViewController(for: taskDate.tasks[indexPath.row],
                                            title: Constants.Title.changeTask)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.08
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: Constants.delete) { _, _ in
            self.viewModel.deleteTask(indexPath: indexPath)
        }
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SeparatorSectionView.initilization(taskDate: viewModel.taskDates[section])
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let taskDate = viewModel.taskDates[section]
        let size: CGFloat = taskDate.tasks.isEmpty ? 0.068 : 0.042
        return taskDate.type != nil ? tableView.frame.height * size : 0
    }
}

//MARK: - CompletedDelegate

extension MainViewController: CompletedDelegate {
    func completed(_ task: Task, for type: TaskDateKey?) {
        viewModel.selectedCompleted(for: task, type: type)
    }
}

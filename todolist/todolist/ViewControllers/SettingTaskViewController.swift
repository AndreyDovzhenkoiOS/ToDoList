//
//  SettingTaskViewController.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 05.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class SettingTaskViewController: BaseViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var cancel: UIBarButtonItem!
    @IBOutlet private weak var save: UIBarButtonItem!
    
    //MARK: - Public Properties
    
    let viewModel = SettingTaskViewModel()
    
    //MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSetting()
    }
    
    //MARK: - IBActions
    
    @IBAction private func saveAction(_ sender: UIBarButtonItem) {
        viewModel.save()
    }
    
    @IBAction private func cancelAction(_ sender: UIBarButtonItem) {
        dismissNewTaskViewController(isSave: false)
    }

    //MARK: - Private functions
    
    private func dismissNewTaskViewController(isSave: Bool) {
        viewModel.selectModelItem(isSave: isSave)
        dismiss(animated: true, completion: nil)
    }
    
    private func defaultSetting() {
        viewModelCompletionHandler()
        settinTableView()
    }
    
    private func allRegisterCells() {
        viewModel.modelCells.forEach {
            tableView.registerCell($0.identifier)
        }
    }
    
    private func viewModelCompletionHandler() {
        viewModel.completionHandler = { [weak self] isEmptyName in
            isEmptyName ?
                self?.present(on: UIAlertController.fillAllFields()) :
                self?.present(on: UIAlertController.emptyNameTask())
        }
        
        viewModel.saveHandler = { [weak self] isSave, isEdit in
            !isSave ?
                self?.present(on: UIAlertController.sameTask()) :
                self?.present(on: UIAlertController.saveTask(isEdit: isEdit, completion: {
                    self?.viewModel.saveNewTask()
                    self?.dismissNewTaskViewController(isSave: isSave)
                }))
        }
    }
    
    private func settinTableView() {
        tableView.settingSeparators()
        allRegisterCells()
    }
    
    private func newTaskCell(for modelCell: ModelCell, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: modelCell.identifier,
                                                 for: indexPath) as? SettingTaskConfigurator
        cell?.initilization(newTask: viewModel.newTask, modelCell: modelCell)
        return cell as! UITableViewCell
    }
}

//MARK: - UITableView

extension SettingTaskViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.modelCells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modelCell = viewModel.modelCells[indexPath.section]
        return newTaskCell(for: modelCell, indexPath: indexPath)
    }

    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.08
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SeparatorSectionView.initilization(taskDate: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modelCell = viewModel.modelCells[indexPath.section]
        guard viewModel.isSelectDateOrTime(modelCell.type) else { return }
        transitionChoiceDateViewController(for: viewModel.newTask, with: modelCell)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard viewModel.checkHeightForHeader(section) else { return 0 }
        return tableView.frame.height * 0.042
    }
}

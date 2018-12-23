//
//  MenuViewController.swift
//  ToDoList
//
//  Created by Anrey Dovzhenko on 05.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class MenuViewController: BaseViewController {

    //MARK: - IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Private property
    
    private let viewModel = MenuViewModel()
    
    // MARK: - Initilization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNumberTasks()
    }

    //MARK: - Public functions
    
    public func viewModelCompletionHandler() {
        viewModel.completionHandler = { [weak self] isNewTask in
            !isNewTask ?
                self?.transitionMainViewController() :
                self?.transitionSettingTaskViewController(for: nil,
                                                          title: Constants.Title.newTask)
            self?.tableView.reloadData()
        }
    }

    //MARK: - Private functions

    private func defaultSetting() {
        viewModelCompletionHandler()
        setTitle(string: Constants.Title.myTask)
        tableView.registerCell(MenuTableViewCell.identifier)
        NotificationCenter.addObserver(self, #selector(update(_:)),
                                       NotificationName.notificationMenuUpdate)
    }
    
    @objc private func update(_ sender: Notification) {
        updateNumberTasks()
    }
    
    private func updateNumberTasks() {
        ModelItemManager.setupNumberTasks()
        tableView.reloadData()
    }
}

//MARK: - UITableView

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.modelItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier) as! MenuTableViewCell
        cell.updateUI(viewModel.modelItems[indexPath.row])
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedModelItem(item: indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.08
    }
}

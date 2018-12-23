//
//  BaseViewController.swift
//  ToDoList
//
//  Created by Anrey Dovzhenko on 05.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet private weak var menuButton: UIBarButtonItem!
    
    // MARK: - Private property
    
    private var filterView: FilterView!
    private var filterButton: FilterButton?
    
    // MARK: - Initilization
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingNavigationBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        guard let filterButton = filterButton,
            filterButton.isSelected else { return }
        applyFilter(for: filterButton)
    }
    
    //MARK: - Private action
    
    @objc private func filterAction(_ sender: FilterButton) {
        applyFilter(for: sender)
    }

    //MARK: - Public functions
    
    public func setTitle(string: String) {
        title = string
    }
    
    public func setupMenu(install: Bool) {
        guard install, let window = UIApplication.shared.windows.first else { return }
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        revealViewController()?.rearViewRevealWidth = window.frame.size.width / 1.2
    }
    
    public func installationFilter(tasksDates: [TaskDate], title: String) {
        installationFilterButton(title: title)
        installationFilterView(taskDates: tasksDates)
    }
    
    //MARK: - Private functions
    
    private func settingNavigationBar() {
        let attributes = [NSAttributedString.Key.font: UIFont.default()]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = .default
        navigationController?.navigationBar.barStyle = UIBarStyle.black
    }
    
    private func installationFilterButton(title: String) {
        guard let navigationFrame = navigationController?.navigationBar.frame else { return }
        filterButton = FilterButton.initilization(title: title, frame: navigationFrame)
        filterButton?.addTarget(self, action: #selector(filterAction(_:)), for: .touchUpInside)
        navigationItem.titleView = filterButton
    }
    
    private func installationFilterView(taskDates: [TaskDate]) {
        guard let frame = navigationController?.navigationBar.frame else { return }
        filterView = FilterView.initilization(navigationFrame: frame, taskDates: taskDates)
        view.addSubview(filterView)
    }

    private func applyFilter(for sender: FilterButton) {
        sender.filterSelected()
        filterView.showFilterView(isSelected: sender.isSelected,
                                  height: view.frame.height / 2.5)
    }
}

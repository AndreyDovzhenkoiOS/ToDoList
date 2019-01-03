//
//  UIViewController.swift.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 05.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

extension UIViewController {
    
    static var storyboardName: String {
        let storyboardName = identifier as NSString
        let range = storyboardName.range(of: Constants.viewController)
        return storyboardName.substring(to: range.location)
    }
    
    public func transitionSettingTaskViewController(for task: Task?, title: String) {
        let modelPresentable = ModelPresentable(storyboardName: SettingTaskViewController.storyboardName,
                                                identifier: SettingTaskViewController.identifier)
        let settingTaskViewController = viewController(modelPresentable) as! SettingTaskViewController
        settingTaskViewController.viewModel.setTask(task: task)
        settingTaskViewController.setTitle(string: title)
        let navigationController = UINavigationController.init(rootViewController: settingTaskViewController)
        present(on: navigationController)
    }
    
    public func transitionMainViewController() {
        let modelPresentable = ModelPresentable(storyboardName: MainViewController.storyboardName,
                                                identifier: MainViewController.identifier)
        let mainViewController = viewController(modelPresentable)
        let navigationController = UINavigationController.init(rootViewController: mainViewController)
        revealViewController().pushFrontViewController(navigationController, animated: true)
    }
    
    public func present(on viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }

    func transitionChoiceDateViewController(for newTask: NewTask?, with modelCell: ModelCell) {
        let modelPresentable = ModelPresentable(storyboardName: SettingTaskViewController.storyboardName,
                                                identifier: ChoiceDateViewController.identifier)
        let choiceDateViewController = viewController(modelPresentable) as! ChoiceDateViewController
        choiceDateViewController.initilization(newTask: newTask, modelCell: modelCell)
        present(on: choiceDateViewController)
    }
    
    func viewController(_ modelPresentable: ModelPresentable) -> UIViewController {
        let storyboard = UIStoryboard(name: modelPresentable.storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: modelPresentable.identifier)
    }
}

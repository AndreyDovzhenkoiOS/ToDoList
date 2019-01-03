//
//  FilterButton.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 07.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class FilterButton: UIButton {
    
    //MARK: - Initilization
    
    static func initilization(title: String, frame: CGRect) -> FilterButton {
        let size = CGSize(width: frame.width / 2, height: frame.height)
        let filterButton = FilterButton(frame: CGRect(origin: CGPoint.zero, size: size))
        filterButton.contentHorizontalAlignment = .left
        filterButton.setImage(UIImage(named: Constants.Image.filterDown.rawValue), for: .normal)
        filterButton.titleLabel?.font = UIFont.default()
        filterButton.setTitle(title, for: .normal)
        filterButton.installArrangement()
        return filterButton
    }
    
    //MARK: - Public function
    
    public func filterSelected() {
        isSelected.toggle()
        setImage(UIImage(named: imageStatusFilter()), for: .normal)
    }
    
    //MARK: - Private functions
    
    private func imageStatusFilter() -> String {
        guard isSelected else { return Constants.Image.filterDown.rawValue }
        return Constants.Image.filterUp.rawValue
    }
    
    private func installArrangement() {
        guard let imageView = imageView, let title = titleLabel?.text else { return }
        let titleLeft = title.size(font: UIFont.default()).width + imageView.frame.width * 4.3
        imageEdgeInsets = UIEdgeInsets(top: 3, left: titleLeft, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: imageView.frame.width * 2.8, bottom: 0, right: 0)
    }
}

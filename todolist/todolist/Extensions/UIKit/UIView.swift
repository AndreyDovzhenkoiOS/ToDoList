//
//  UIView.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 11.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

extension UIView {
    
    static public func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self),
                                        owner: nil, options: nil)!.first as! T
    }
    
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let size = CGSize(width: radius, height: radius)
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: size)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    public func roundTop(radius:CGFloat = 8){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func animateSelect(completion: @escaping VoidCallback) {
        let duration = 0.2
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            self.alpha = 0.3
        }) { _ in
            UIView.animate(withDuration: duration, animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.alpha = 1
            }) { _ in completion()}
        }
    }
}

//
//  AppUIBarButtonItem.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/14/21.
//

import UIKit

class AppUIBarButtonItem: UIBarButtonItem {
    
    convenience init(image: UIImage, target: Any, selector: Selector) {
        let barButton = UIButton.makeNavigationBarButton()
        barButton.setImage(image, for: .normal)
        barButton.addTarget(target, action: selector, for: .touchUpInside)
        
        self.init(customView: barButton)
    }

//    convenience init(title: String, target: Any, selector: Selector) {
//        let barButton = UIButton.makeNavigationBarButton()
//        barButton.addTarget(target, action: selector, for: .touchUpInside)
//
//        self.init(customView: barButton)
//    }
    
    private override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

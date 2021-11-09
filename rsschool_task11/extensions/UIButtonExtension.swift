//
//  UIButtonExtension.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/14/21.
//

import UIKit

extension UIButton {
    
    static func makeNavigationBarButton() -> UIButton {
        let button = UIButton()
        button.tintColor = .coral
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

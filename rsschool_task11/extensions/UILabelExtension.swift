//
//  UILabelExtension.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/13/21.
//

import UIKit

extension UILabel {
    
    static func makeRocketCardLablelWith(font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func makeRocketCardLablelWith(font: UIFont, color: UIColor, text: String) -> UILabel {
        let label = makeRocketCardLablelWith(font: font, color: color)
        label.text = text
        return label
    }

}

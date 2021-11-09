//
//  UIStackViewExtension.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/13/21.
//

import UIKit

extension UIStackView {
    
    static func makeVerticalFillStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    static func makeVerticalFillStack1() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    static func makeVerticalFillStackWith(arrangedSubviews: [UIView]) -> UIStackView {
        let stack = makeVerticalFillStack()
        arrangedSubviews.forEach{stack.addArrangedSubview($0)}
        return stack
    }
    
    static func makeHorizontalFillEquallyStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    static func makeHorizontalFillEquallyStackWith(arrangedSubviews: [UIView]) -> UIStackView {
        let stack = makeHorizontalFillEquallyStack()
        arrangedSubviews.forEach{stack.addArrangedSubview($0)}
        return stack
    }
    
    static func makeHorizontalFillProportionallyStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    static func makeHorizontalFillProportionallyStackWith(arrangedStackSubviews: [UIStackView]) -> UIStackView {
        let stack = makeHorizontalFillProportionallyStack()
        arrangedStackSubviews.forEach{stack.addArrangedSubview($0)}
        return stack
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach{addArrangedSubview($0)}
    }
    
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { removeFully(view: $0)}
    }
}

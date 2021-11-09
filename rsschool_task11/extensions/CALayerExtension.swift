//
//  CALayerExtension.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 10/5/21.
//

import UIKit

extension CALayer {
    
    convenience init(radius: CGFloat, color: CGColor, offset: CGSize, opacity: Float) {
        self.init()
        shadowRadius = radius
        shadowColor = color
        shadowOffset = offset
        shadowOpacity = opacity
    }
    
}

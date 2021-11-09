//
//  FontBook.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/27/21.
//

import UIKit

enum Roboto: String {
    
    case bold = "Roboto-Bold"
    case medium = "Roboto-Medium"
        
    func of(style: UIFont.TextStyle) -> UIFont {
        guard let size = fontSizes[style] else {
            fatalError("Cannot find text size")
        }
        
        let customFont = UIFont(name: self.rawValue, size: size)
        let font = customFont != nil ? customFont! : UIFont.systemFont(ofSize: size)
                
        let metrics = UIFontMetrics(forTextStyle: style)
        
        return metrics.scaledFont(for: font)
    }
}

extension Roboto {
    
    private var fontSizes: [UIFont.TextStyle: CGFloat] {
        [
            .largeTitle: 24,
            .body: 14,
            
            .title1: 28,
            .title2: 22,
            .title3: 20,
            .headline: 17,
            
            .callout: 16,
            .subheadline: 15,
            .footnote: 13,
            .caption1: 12,
            .caption2: 11
        ]
    }
}

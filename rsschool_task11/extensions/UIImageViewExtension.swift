//
//  UIImageViewExtension.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/14/21.
//

import UIKit

extension UIImageView {
    
    func loadImage(at url: String, indexPath: IndexPath) {
        FileHandler.handler.downloadImageWith(urlString: url, for: self, for: indexPath)
    }
}

//
//  RocketUIImageView.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 10/5/21.
//

import UIKit

class RocketUIImageView: UIImageView {
    
    var didSetImageBlock: ((_ image: UIImage?) -> Void)?
    
    override var image: UIImage? {
        didSet {
            super.image = image
            if let didSetImage = didSetImageBlock {
                didSetImage(image)
            }
        }
    }

}

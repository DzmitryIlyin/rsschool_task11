//
//  AutoLayoutCollectionView.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/28/21.
//

import UIKit

class AutoLayoutCollectionView: UICollectionView {

//    private var shouldInvalidateLayout = false
//
//        override func layoutSubviews() {
//            super.layoutSubviews()
//            if shouldInvalidateLayout {
//                collectionViewLayout.invalidateLayout()
//                shouldInvalidateLayout = false
//            }
//        }
//
//        override func reloadData() {
//            shouldInvalidateLayout = true
//            super.reloadData()
//        }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            if bounds.size != intrinsicContentSize {
                invalidateIntrinsicContentSize()
            }
        }

        override var intrinsicContentSize: CGSize {
            return self.contentSize
        }

}

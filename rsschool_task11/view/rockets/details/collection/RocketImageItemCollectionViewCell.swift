//
//  RocketImageItemCollectionViewCell.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/28/21.
//

import UIKit

class RocketImageItemCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: RocketUIImageView = {
        let view = RocketUIImageView()
        view.backgroundColor = .taskWhite
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.backgroundColor = .taskWhite
        return view
    }()
    
    private lazy var layerRightOffset: CALayer = CALayer(radius: 3, color: UIColor(red: 174/255, green: 174/255, blue: 192/255, alpha: 0.4).cgColor, offset: CGSize(width: 1.5, height: 1.5), opacity: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = .taskWhite
        
        addLayersFunc()
        addSubviews()
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if imageView.layer.cornerRadius != imageView.bounds.height * 0.037 {
            
            imageView.layer.cornerRadius = imageView.bounds.height * 0.037
            imageView.setBorder(width: imageView.bounds.height * 0.016, color: .taskWhite)
            
            addLayerGeoFunc()
        }
        
    }
    
    private func addLayersFunc() {
        shadowView.layer.addSublayer(layerRightOffset)
    }
    
    private func addLayerGeoFunc() {
        layerRightOffset.cornerRadius = imageView.bounds.height * 0.037
        layerRightOffset.frame = imageView.bounds
        layerRightOffset.shadowPath = UIBezierPath(roundedRect: imageView.bounds, cornerRadius: 10).cgPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        shadowView.addSubview(imageView)
        contentView.addSubview(shadowView)
    }
    
    private func setupConstraints() {
        imageView.fillSuperview()
        shadowView.fillSuperview()
    }
    
    func configure(imagePath: String, indexPath: IndexPath) {
        //        imageView.didSetImageBlock = { [weak self] (image: UIImage?) in
        //            self?.addShadows()
        //        }
        imageView.loadImage(at: imagePath, indexPath: indexPath)
    }
    
}

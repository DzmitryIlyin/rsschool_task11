//
//  RocketDetailsThemeTableViewCell.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/17/21.
//

import UIKit

class RocketDetailsThemeTableViewCell: UITableViewCell {
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.contentView.backgroundColor = .red
//        self.contentView.addSubview(image)
    }
    
    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            image.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
//            image.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
//            image.topAnchor.constraint(equalTo: contentView.topAnchor),
//            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//        ])
    }
    
    func configure(image: UIImage) {
//        self.imageView?.image = image
//        self.image.image = image
    }

}

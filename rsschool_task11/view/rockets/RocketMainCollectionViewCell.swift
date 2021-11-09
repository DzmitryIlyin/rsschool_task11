//
//  RocketMainCollectionViewCell.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/13/21.
//

import UIKit

class RocketMainCollectionViewCell: UICollectionViewCell {
    
    private lazy var rocketCardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rockets_placeholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var titleLabel = UILabel.makeRocketCardLablelWith(font: Roboto.bold.of(style: .largeTitle), color: .smokyBlack)
    
    private lazy var descriptionStack = UIStackView.makeHorizontalFillProportionallyStackWith(arrangedStackSubviews: [firstLaunchStack, launchCostStack, successStack])
    
    private lazy var firstLaunchStack = UIStackView.makeVerticalFillStackWith(arrangedSubviews: [firstLaunchSectionLabel, firstLaunchLabel])
    private lazy var firstLaunchSectionLabel = UILabel.makeRocketCardLablelWith(font: Roboto.bold.of(style: .body), color: .black, text: "First launch")
    private lazy var firstLaunchLabel = UILabel.makeRocketCardLablelWith(font: Roboto.bold.of(style: .body), color: .slateGray)
    
    private lazy var launchCostStack = UIStackView.makeVerticalFillStackWith(arrangedSubviews: [launchCostSectionLabel, launchCostLabel])
    private lazy var launchCostSectionLabel = UILabel.makeRocketCardLablelWith(font: Roboto.bold.of(style: .body), color: .black, text: "Launch cost")
    private lazy var launchCostLabel = UILabel.makeRocketCardLablelWith(font: Roboto.bold.of(style: .body), color: .slateGray)
    
    private lazy var successStack = UIStackView.makeVerticalFillStackWith(arrangedSubviews: [successSectionLabel, successLabel])
    private lazy var successSectionLabel = UILabel.makeRocketCardLablelWith(font: Roboto.bold.of(style: .body), color: .black, text: "Success")
    private lazy var successLabel = UILabel.makeRocketCardLablelWith(font: Roboto.bold.of(style: .body), color: .slateGray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .taskWhite
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubviews() {
        contentView.addSubview(rocketCardImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionStack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            rocketCardImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            rocketCardImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            rocketCardImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            rocketCardImageView.heightAnchor.constraint(equalToConstant: contentView.bounds.height * 0.66),
            
            titleLabel.topAnchor.constraint(equalTo: rocketCardImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            descriptionStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            descriptionStack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionStack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            descriptionStack.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rocketCardImageView.image = UIImage(named: "rockets_placeholder")
    }
    
    func configure(rocketCompactCard: RocketCompactCard, indexPath: IndexPath) {
        titleLabel.text = rocketCompactCard.name
        firstLaunchLabel.text = String(describing: rocketCompactCard.firstFlight)
        launchCostLabel.text = String(describing: "\(rocketCompactCard.costPerLaunch)$")
        successLabel.text = String(describing: "\(rocketCompactCard.successRatePct)%")
        if let image = rocketCompactCard.themeImagePath {
            rocketCardImageView.loadImage(at: image, indexPath: indexPath)
        }
    }
}

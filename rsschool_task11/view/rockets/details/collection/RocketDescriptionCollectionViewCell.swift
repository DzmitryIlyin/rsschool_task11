//
//  DescriptionCollectionViewCell.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/15/21.
//

import UIKit

class RocketDescriptionCollectionViewCell: UICollectionViewCell {
        
    private lazy var descriptionStackView = UIStackView.makeVerticalFillStack()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(descriptionStackView)
    }
    
    private func setupConstraints() {
//        descriptionTitleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            descriptionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            descriptionStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            descriptionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(section: Section) {
        let descriptionTitleLabel = UILabel.makeRocketCardLablelWith(font: Roboto.medium.of(style: .largeTitle), color: .smokyBlack, text: section.title)
        let descriptionTextLabel = UILabel.makeRocketCardLablelWith(font: Roboto.medium.of(style: .body), color: .smokyBlack, text: section.data.first!.values.first!)
        
        descriptionStackView.addArrangedSubviews([descriptionTitleLabel, descriptionTextLabel])
        descriptionStackView.setCustomSpacing(10, after: descriptionTitleLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionStackView.removeFullyAllArrangedSubviews()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        frame.size.width = UIScreen.main.bounds.width
        
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
    
}

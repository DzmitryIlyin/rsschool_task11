//
//  RocketRegularCollectionViewCell.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/24/21.
//

import UIKit

class RocketRegularCollectionViewCell: UICollectionViewCell {
    
    private lazy var sectionTitleLabel = UILabel.makeRocketCardLablelWith(font: Roboto.medium.of(style: .largeTitle), color: .smokyBlack)
    private lazy var sectionStackView = UIStackView.makeVerticalFillStack()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = .taskWhite
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(sectionStackView)
    }
    
    private func setupConstraints() {
        sectionTitleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            sectionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sectionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            sectionStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            sectionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(section: Section) {
        sectionStackView.addArrangedSubview(sectionTitleLabel)
        sectionStackView.setCustomSpacing(10, after: sectionTitleLabel)
        sectionTitleLabel.text = section.title
        
        let overviewTitleStack = UIStackView.makeVerticalFillStack()
        let overviewSubtitleStack = UIStackView.makeVerticalFillStack()
        
        section.data.forEach{(value) in
            value.forEach{(key, value) in
                prepareOverviewRowItem(color: .smokyBlack, text: key, stack: overviewTitleStack)
                prepareOverviewRowItem(color:.slateGray, text: value, stack: overviewSubtitleStack)
            }
        }
        let overviewLaneStackView = UIStackView.makeHorizontalFillEquallyStackWith(arrangedSubviews: [overviewTitleStack, overviewSubtitleStack])
        sectionStackView.addArrangedSubview(overviewLaneStackView)
    }
    
    private func prepareOverviewRowItem(color: UIColor, text: String, stack: UIStackView) {
        let overviewTitleLabel = UILabel.makeRocketCardLablelWith(font: Roboto.bold.of(style: .body), color: color, text: text)
        overviewTitleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        stack.addArrangedSubview(overviewTitleLabel)
        stack.setCustomSpacing(8, after: overviewTitleLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sectionStackView.removeFullyAllArrangedSubviews()
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

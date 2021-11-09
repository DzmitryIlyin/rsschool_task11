//
//  RocketImageCollectionViewCell.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/28/21.
//

import UIKit

class RocketImageCollectionViewCell: UICollectionViewCell {
    
    private let rocketImageItemCellId = "rocketImageItemCell"
    private var sectionData: Section?
    
    private lazy var sectionTitleLabel = UILabel.makeRocketCardLablelWith(font: Roboto.medium.of(style: .largeTitle), color: .smokyBlack)
    private lazy var imageStack = UIStackView.makeVerticalFillStack1()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.31, height: UIScreen.main.bounds.height * 0.21)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .taskWhite
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(RocketImageItemCollectionViewCell.self, forCellWithReuseIdentifier: rocketImageItemCellId)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func addSubviews() {
        contentView.addSubview(imageStack)
    }
    
    private func setupConstraints() {
        imageStack.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    func configure(section: Section) {
        imageStack.addArrangedSubviews([sectionTitleLabel, collectionView])
        imageStack.setCustomSpacing(ImageCellConstants.headerSpacing, after: sectionTitleLabel)

        sectionData = section
        sectionTitleLabel.text = sectionData!.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageStack.removeFullyAllArrangedSubviews()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        var frame = attributes.frame
        let labelHeight = sectionTitleLabel.systemLayoutSizeFitting(attributes.size).height
        let imageHeight = UIScreen.main.bounds.height * 0.21
        frame.size.height = ceil(labelHeight + imageHeight + ImageCellConstants.headerSpacing)
        frame.size.width = UIScreen.main.bounds.width
        attributes.frame = frame

        return attributes
    }
    
}

extension RocketImageCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sectionData!.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imagePath = sectionData!.data[indexPath.item].first!.value
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rocketImageItemCellId, for: indexPath) as! RocketImageItemCollectionViewCell
        cell.configure(imagePath: imagePath, indexPath: indexPath)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let screenSize = UIScreen.main.bounds
//        return CGSize(width: screenSize.width * 0.31, height: screenSize.height * 0.21)
//    }
    
}

private enum ImageCellConstants {
    static let headerSpacing = 10.0
}

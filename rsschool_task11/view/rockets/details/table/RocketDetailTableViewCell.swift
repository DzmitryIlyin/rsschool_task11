//
//  CustomTableViewCell.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/16/21.
//

import UIKit

class RocketDetailTableViewCell: UITableViewCell {
    
    private lazy var descriptionTitleLabel = UILabel.makeRocketCardLablelWith(font: Roboto.bold.of(style: .largeTitle), color: .smokyBlack)
    
    private lazy var descriptionTextLabel = UILabel.makeRocketCardLablelWith(font: Roboto.medium.of(style: .body), color: .smokyBlack)
    
    private lazy var descriptionStackView = UIStackView.makeVerticalFillStackWith(arrangedSubviews: [descriptionTitleLabel, descriptionTextLabel])

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        descriptionStackView.setCustomSpacing(20, after: descriptionTitleLabel)
        self.contentView.addSubview(descriptionStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            descriptionStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            descriptionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(section: Section) {
        descriptionTitleLabel.text = section.title
        descriptionTextLabel.text = section.data.first!["desctiption"]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


}

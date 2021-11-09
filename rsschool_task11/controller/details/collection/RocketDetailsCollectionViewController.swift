//
//  RocketDetailsCollectionViewController.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/22/21.
//

import UIKit

class RocketDetailsCollectionViewController: UIViewController {
    
    private let rocketDetailHeaderCellId = "rocketDetailHeaderCell"
    private let rocketDescriptionCellId = "rocketDescriptionCell"
    private let rocketRegularCellId = "rocketRegularCell"
    private let rocketImageCellId = "rocketImageCell"
    
    var id: String?
    var themeImagePath: String?
    
    private var rocket: RocketCard?
    private var sectonData: [Section] = []
    
    var activityIndicator = UIActivityIndicatorView()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: view.bounds.width, height: 300)
        layout.minimumLineSpacing = 20
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .taskWhite
        collectionView.showsVerticalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.register(RocketDetailHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: rocketDetailHeaderCellId)
        collectionView.register(RocketDescriptionCollectionViewCell.self, forCellWithReuseIdentifier: rocketDescriptionCellId)
        collectionView.register(RocketRegularCollectionViewCell.self, forCellWithReuseIdentifier: rocketRegularCellId)
        collectionView.register(RocketImageCollectionViewCell.self, forCellWithReuseIdentifier: rocketImageCellId)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .taskWhite
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        loadData()
        setupNavigationBar()
        addSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.layoutIfNeeded()
    }
    
    private func loadData() {
        activityIndicator.startAnimating()
        
        let client = RocketClient()
        client.getRocket(id: id!) { [weak self] (result: Result<RocketCard, APIError>) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                self.rocket = response
                self.prepareSections()
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func prepareSections() {
        let rocketHelper = RocketHelper()
        sectonData = rocketHelper.splitRocket(rocket: rocket!)
    }

    private func setupNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let leftNavBarItem = AppUIBarButtonItem(image: UIImage(named: "arrow_left")!, target: self, selector: #selector(handleSegue(sender:)))
        self.navigationItem.leftBarButtonItem = leftNavBarItem
    }

    
    @objc private func handleSegue(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func addSubviews() {
        self.view.addSubview(activityIndicator)
        self.view.addSubview(collectionView)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
}

extension RocketDetailsCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sectonData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sectonData[indexPath.item]
        
        switch section.kind {
        case .description:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rocketDescriptionCellId, for: indexPath) as! RocketDescriptionCollectionViewCell
            cell.configure(section: section)
            return cell
        case .regularSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rocketRegularCellId, for: indexPath) as! RocketRegularCollectionViewCell
            cell.configure(section: section)
            return cell
        case .image:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rocketImageCellId, for: indexPath) as! RocketImageCollectionViewCell
            cell.configure(section: section)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rocketRegularCellId, for: indexPath) as! RocketRegularCollectionViewCell
            cell.configure(section: section)
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: view.bounds.height * 0.42)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: rocketDetailHeaderCellId, for: indexPath) as! RocketDetailHeaderCollectionViewCell
            if let imagePath = themeImagePath {
                header.configure(imagePath: imagePath, indexPath: indexPath)
            }
            return header
        default:
            fatalError()
        }
    }
    
}

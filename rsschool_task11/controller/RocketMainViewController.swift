//
//  RocketMainViewController.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/10/21.
//

import UIKit

class RocketMainViewController: UIViewController {
    
    private var rockets: [RocketCompactCard] = []
    private var activityIndicator = UIActivityIndicatorView()
    private let fileManager = FileHandler.handler
    private static let rocketCellId = "rocketMainCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = self.view.bounds.width * 0.07
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.backgroundColor = .queenBlue
        collectionView.showsVerticalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.register(RocketMainCollectionViewCell.self, forCellWithReuseIdentifier: RocketMainViewController.rocketCellId)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .queenBlue
        
        loadData()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        addSubviews()
        setupConstraints()
        
    }
    
    private func loadData() {
        activityIndicator.startAnimating()
        
        let client = RocketClient()
        client.getRockets { [weak self] (result: Result<[RocketCompactCard], APIError>) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                self.rockets = response
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func handleError(error: Error) {
        if let err = error as? APIError {
            print(err.localizedDescription)
        } else {
            print(error.localizedDescription)
        }
    }
    
    private func addSubviews() {
        self.view.addSubview(activityIndicator)
        self.view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension RocketMainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketMainViewController.rocketCellId, for: indexPath) as! RocketMainCollectionViewCell
            let rocket = rockets[indexPath.item]
            
            cell.configure(rocketCompactCard: rocket, indexPath: indexPath)
        
        return cell
    }

//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        fileManager.suspendImageDownloadQueue()
//
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//      // 2
//      if !decelerate {
//        fileManager.resumeImageDownloadQueue()
//      }
//    }
//
//     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//      // 3
//        fileManager.resumeImageDownloadQueue()
//        for value in 0..<collectionView.numberOfItems(inSection: 0) where
//    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        fileManager.cancelImageDownload(indexPath: indexPath)
    }
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rockets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height * 0.45
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension RocketMainViewController {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rocket = rockets[indexPath.item]
        
//        let rocketDetailVC = RocketDetailViewController(style: .plain)
        let rocketDetailVC = RocketDetailsCollectionViewController()
        rocketDetailVC.id = rocket.id
        rocketDetailVC.themeImagePath = rocket.themeImagePath
        self.navigationController?.pushViewController(rocketDetailVC, animated: true)
    }
}


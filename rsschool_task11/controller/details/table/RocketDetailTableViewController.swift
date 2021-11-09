//
//  RocketDetailViewController.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/14/21.
//

import UIKit

class RocketDetailTableViewController: UITableViewController {
    
    private let rocketDetailCellId = "rocketDetailCell"
    private let rocketDetailHeaderCellId = "rocketDetailHeaderCell"
    private let rocketDescriptionCellId = "rocketDescriptionCell"
    
    var id: String?
    var themeImage: UIImage?
    private var imageV: UIImageView = {
       let imgV = UIImageView()
        imgV.translatesAutoresizingMaskIntoConstraints = false
        return imgV
    }()
    private var rocket: RocketCard?
    private var sectonData: [Section] = []
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .red
        
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        
        tableView.register(RocketDetailTableViewCell.self, forCellReuseIdentifier: "tableCell")
        
        
        tableView.tableHeaderView = imageV
        imageV.image =  UIImage(named: "rockets_placeholder")!
        loadData()
                
        setupNavigationBar()
        addSubviews()
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
                self.tableView.reloadData()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        print("HANDLE")
    }
    
    private func addSubviews() {
        self.view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            
            tableView.tableHeaderView!.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            tableView.tableHeaderView!.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.42),
            
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    
}

extension RocketDetailTableViewController{
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectonData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sectonData[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! RocketDetailTableViewCell
        cell.configure(section: section)
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
}



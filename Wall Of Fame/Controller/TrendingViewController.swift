//
//  ViewController.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    private var loadingView: UIView!
    private var indicator: UIActivityIndicatorView!

    var trendingViewModel:TrendingViewModel = TrendingViewModel(webService: WebService.shared)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.register(UINib(nibName: "GitRepositoryTableViewCell", bundle: .main), forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        // Do any additional setup after loading the view.
        
        fetchTrendingRepositories()
    }
    func fetchTrendingRepositories(){
        createLoadingView()
        indicator.startAnimating()
        trendingViewModel.fetchTrendingRepositories(tableView: self.tableView) { (success) in
            self.indicator.stopAnimating()
            self.tableView.tableFooterView = nil
        }
    }

}

extension TrendingViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == trendingViewModel.getTrendingRepoCount() - 1{
            fetchTrendingRepositories()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GitRepositoryTableViewCell
        let repo = trendingViewModel.trendingGitRepositories[indexPath.row]
        cell.setup(repo: repo)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingViewModel.getTrendingRepoCount()
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        guard let currentPage = tableView.indexPathsForVisibleRows?.last else{return}
//        if currentPage.row == trendingViewModel.getTrendingRepoCount() - 10{
//            fetchTrendingRepositories()
//        }

    }
    private func createLoadingView() {

        loadingView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        indicator = UIActivityIndicatorView()
        indicator.color = UIColor.lightGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        loadingView.addSubview(indicator)
        centerIndicator()
        self.tableView.tableFooterView = loadingView
    }
    private func centerIndicator() {
        let xCenterConstraint = NSLayoutConstraint(
            item: loadingView, attribute: .centerX, relatedBy: .equal,
            toItem: indicator, attribute: .centerX, multiplier: 1, constant: 0
        )
        loadingView.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(
            item: loadingView, attribute: .centerY, relatedBy: .equal,
            toItem: indicator, attribute: .centerY, multiplier: 1, constant: 0
        )
        loadingView.addConstraint(yCenterConstraint)
    }

}

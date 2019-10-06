//
//  ViewController.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController {

    @IBOutlet weak var tableView:DefaultTableView!

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
        self.tableView.startLoader()
        trendingViewModel.fetchTrendingRepositories(tableView: self.tableView)
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
}

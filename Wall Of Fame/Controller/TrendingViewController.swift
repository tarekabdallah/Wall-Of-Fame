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
    
    var trendingViewModel:TrendingViewModel = TrendingViewModel(webService: WebService.shared)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
        trendingViewModel.fetchTrendingRepositories { (success) in
            self.tableView.reloadData()
        }
    }


}

extension TrendingViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = trendingViewModel.getRepoName(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingViewModel.getTrendingRepoCount()
    }
}

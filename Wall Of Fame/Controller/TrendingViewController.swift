//
//  ViewController.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController {
    @IBOutlet weak var tableView: DefaultTableView!
    var trendingViewModel: TrendingViewModel = TrendingViewModel(webService: WebService.shared)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.register(UINib(nibName: GitRepositoryTableViewCellStrings.nibName.rawValue,
                                 bundle: .main),
                           forCellReuseIdentifier: GitRepositoryTableViewCellStrings.cellIdentifier.rawValue)
        tableView.separatorStyle = .none
        tableView.emptyStateDelegate = self
        fetchTrendingRepositories()
    }

    func fetchTrendingRepositories() {
        self.tableView.startLoader()
        trendingViewModel.fetchTrendingRepositories(tableView: self.tableView)
    }
}

extension TrendingViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == trendingViewModel.getTrendingRepoCount() - 1 {
            fetchTrendingRepositories()
        }
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: GitRepositoryTableViewCellStrings.cellIdentifier.rawValue,
                                                       for: indexPath) as? GitRepositoryTableViewCell else {
            return UITableViewCell()
        }
        let repo = trendingViewModel.trendingGitRepositories[indexPath.row]
        cell.setup(repo: repo)
        cell.ownerAliasImageView.downloadedFrom(link: trendingViewModel.getRepoOwnerAvatarURL(index: indexPath.row),
                                           tableView: tableView,
                                           indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingViewModel.getTrendingRepoCount()
    }
}
extension TrendingViewController: EmptyStateViewDelegate {
    
    func reloadButtonPressed() {
        self.tableView.removeEmptyStateView()
        trendingViewModel.fetchTrendingRepositories(tableView: self.tableView)
    }
}

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
    
    var trendingRepositories:[TrendingViewModel] = [TrendingViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }


}

extension TrendingViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingRepositories.count
    }
}

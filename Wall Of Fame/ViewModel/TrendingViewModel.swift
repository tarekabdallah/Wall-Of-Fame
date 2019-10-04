//
//  TrendingViewModel.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
import Alamofire
class TrendingViewModel{
    private(set) var webService :WebService!
    
    var trendingGitRepositories:[GitRepositoryModel] = [GitRepositoryModel]()
    var page:Int = 0
    init(webService:WebService) {
        self.webService = webService
    }
}
extension TrendingViewModel{
    func getRepoName(index:Int) -> String{
        return trendingGitRepositories[index].name
    }
    
    func getRepoDescription(index:Int) -> String{
        return trendingGitRepositories[index].description
    }

    func getRepoURL(index:Int) -> String{
        return trendingGitRepositories[index].url
    }

    func getRepoStars(index:Int) -> Int{
        return trendingGitRepositories[index].stars
    }
    func getRepoOwnerName(index:Int) -> String{
        return trendingGitRepositories[index].owner.name
    }
    func getRepoOwnerAvatarURL(index:Int) -> URL{
        return URL(string: trendingGitRepositories[index].owner.avatar)!
    }
    func getRepoOwnerAccountURL(index:Int) -> URL{
        return URL(string: trendingGitRepositories[index].owner.accountURL)!
    }
    func getTrendingRepoCount() -> Int{
        return trendingGitRepositories.count
    }

    func fetchTrendingRepositories(tableView:UITableView? = nil, completed:((_ success:Bool,_ message:String? )->Void)? = nil){
        self.webService.requestFetchGitRepositories(page: page, success: { (trendingRepositories) in
            var indexes:[IndexPath] = []
            for repo in trendingRepositories{
                indexes.append(IndexPath(row: self.trendingGitRepositories.count , section: 0))
                self.trendingGitRepositories.append(repo)
            }
            tableView?.insertRows(at: indexes, with: .right)

            self.page += 1
            print("page: \(self.page) size: \(trendingRepositories.count) totalSize: \(self.getTrendingRepoCount())")
            completed?(true,nil)
        }) { (message) in
            UIView.showErrorDialog(title: "Couldn't fetch repositories.", details: message, retry: {
                self.fetchTrendingRepositories(tableView: tableView, completed: completed)
            })
            completed?(false,message)
        } 
    }
}

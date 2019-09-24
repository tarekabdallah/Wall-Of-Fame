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
    
    private var trendingGitRepositories:[GitRepositoryModel] = [GitRepositoryModel]()
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

    func fetchTrendingRepositories(completed:@escaping (_ success:Bool)->Void){
        self.webService.requestFetchGitRepositories(page: page, success: { (trendingRepositories) in
            self.trendingGitRepositories = trendingRepositories
            self.page += 1
            completed(true)
        }) { (message) in
            completed(false)
        }
    }
}

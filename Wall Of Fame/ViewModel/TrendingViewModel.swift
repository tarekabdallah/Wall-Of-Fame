//
//  TrendingViewModel.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
class TrendingViewModel{
    private let gitRepositories:[GitRepositoryModel]
    init(gitRepositories:[GitRepositoryModel]) {
        self.gitRepositories = gitRepositories
    }
}
extension TrendingViewModel{
    func getRepoName(index:Int) -> String{
        return gitRepositories[index].name
    }
    
    func getRepoDescription(index:Int) -> String{
        return gitRepositories[index].description
    }

    func getRepoURL(index:Int) -> String{
        return gitRepositories[index].url
    }

    func getRepoStars(index:Int) -> Int{
        return gitRepositories[index].stars
    }
    func getRepoOwnerName(index:Int) -> String{
        return gitRepositories[index].owner.name
    }
    func getRepoOwnerAvatarURL(index:Int) -> URL{
        return URL(string: gitRepositories[index].owner.avatar)!
    }
    func getRepoOwnerAccountURL(index:Int) -> URL{
        return URL(string: gitRepositories[index].owner.accountURL)!
    }


}

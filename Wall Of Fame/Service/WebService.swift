//
//  WebService.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
import Alamofire
class WebService {
    static let shared = WebService()
    func requestFetchGitRepositories(page:Int, success:@escaping (_ repositories:[GitRepositoryModel]) -> Void, failure:@escaping (_ message:String) -> Void){
        let url = "https://api.github.com/search/repositories?q=created:>2017-10-22&sort=stars&order=desc&page=\(page)"
        
        Alamofire.request(url).responseRepositories { (response) in
            if let error = response.error{
                failure(error.localizedDescription)
                return
            }
            if let repositories = response.result.value{
                success(repositories)
                return
            }
        }
    }
}

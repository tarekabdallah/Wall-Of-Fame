//
//  WebService.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
class WebService {
    static let shared = WebService()
    func requestFetchGitRepositories(page: Int,
                                     success: @escaping (_ repositories: [GitRepositoryModel]) -> Void,
                                     failure: @escaping (_ message: String) -> Void) {
        let url = "https://api.github.com/search/repositories"
        var dateComponent = DateComponents()
        dateComponent.day = -30
        let date = Calendar.current.date(byAdding: dateComponent, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.isLenient = true
            dateFormatter.dateFormat  = "yyyy-MM-dd"

        Alamofire.request(url,
                          parameters: ["q": "created:>\(dateFormatter.string(from: date))",
                            "sort": "stars",
                            "order": "desc",
                            "page": page],
                          encoding: URLEncoding.queryString)
            .responseArray(queue: DispatchQueue.main,
                           keyPath: "items") { (response: DataResponse<[GitRepositoryModel]>) in
            if let error = response.error {
                let json = try? JSONSerialization.jsonObject(with: response.data ?? Data(),
                                                             options: JSONSerialization
                                                                .ReadingOptions
                                                                .mutableLeaves) as? [String: Any]
                failure(json?["message"] as? String ?? error.localizedDescription)
                return
            }
            if let repositories = response.result.value {
                success(repositories)
                return
            }

        }
    }
}

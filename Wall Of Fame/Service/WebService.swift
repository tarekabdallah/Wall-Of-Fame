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
enum WebServiceConstants:String{
    case serverURL = "https://api.github.com/search/repositories"
    case message = "message"
    case items = "items"
}
enum WebServiceParametersString:String{
    case query = "q"
    case sort = "sort"
    case order = "order"
    case page = "page"
}
enum GitServerOrderingString: String {
    case ascending = "asc"
    case descending = "desc"
}
enum GitServerItemsString: String {
    case star = "star"
}

class WebService {
    static let shared = WebService()
    func requestFetchGitRepositories(page: Int,
                                     success: @escaping (_ repositories: [GitRepositoryModel]) -> Void,
                                     failure: @escaping (_ message: String) -> Void) {
        
        var dateComponent = DateComponents()
        dateComponent.day = -30
        let date = Calendar.current.date(byAdding: dateComponent, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.isLenient = true
            dateFormatter.dateFormat  = "yyyy-MM-dd"

        Alamofire.request(WebServiceConstants.serverURL.rawValue,
                          parameters: [WebServiceParametersString.query.rawValue: "created:>\(dateFormatter.string(from: date))",
                            WebServiceParametersString.sort.rawValue: GitServerItemsString.star.rawValue,
                            WebServiceParametersString.order.rawValue: GitServerOrderingString.descending.rawValue,
                            WebServiceParametersString.page.rawValue: page],
                          encoding: URLEncoding.queryString)
            .responseArray(queue: DispatchQueue.main,
                           keyPath: WebServiceConstants.items.rawValue) { (response: DataResponse<[GitRepositoryModel]>) in
            if let error = response.error {
                let json = try? JSONSerialization.jsonObject(with: response.data ?? Data(),
                                                             options: JSONSerialization
                                                                .ReadingOptions
                                                                .mutableLeaves) as? [String: Any]
                failure(json?[WebServiceConstants.message.rawValue] as? String ?? error.localizedDescription)
                return
            }
            if let repositories = response.result.value {
                success(repositories)
                return
            }

        }
    }
}

//
//  WebService.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation


class WebService {
    static let shared = WebService()

    enum WebServiceConstants: String {
        case serverURL = "https://api.github.com/search/repositories"
        case message = "message"
        case items = "items"
    }

    enum WebServiceParametersString: String {
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
        case star
    }

    func requestFetchGitRepositories(page: Int,
                                     success: @escaping (_ repositories: [GitRepositoryModel]) -> Void,
                                     failure: @escaping (_ message: String) -> Void) {
        var dateComponent = DateComponents()
        dateComponent.day = -30
        let date = Calendar.current.date(byAdding: dateComponent, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.isLenient = true
        dateFormatter.dateFormat  = "yyyy-MM-dd"
        var urlComponents = URLComponents(string: WebServiceConstants.serverURL.rawValue)
        urlComponents?.queryItems = [ URLQueryItem(name: WebServiceParametersString
            .query
            .rawValue, value: "created:>\(dateFormatter.string(from: date))"),
        URLQueryItem(name: WebServiceParametersString.sort.rawValue,
                     value: GitServerItemsString.star.rawValue),
        URLQueryItem(name: WebServiceParametersString.order.rawValue,
                     value: GitServerOrderingString.descending.rawValue),
        URLQueryItem(name: WebServiceParametersString.page.rawValue,
                     value: "\(page)")
        ]
        guard let url = urlComponents?.url else {
            return
        }

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { (responseData, response, error) in
            let httpResponse = response as? HTTPURLResponse
            guard error == nil && (httpResponse?.statusCode ?? 0) == 200 else {
                let json = try? JSONSerialization.jsonObject(with: responseData ?? Data(),
                                                             options: JSONSerialization
                                                                .ReadingOptions
                                                                .mutableLeaves) as? [String: Any]
                DispatchQueue.main.async {
                    failure(json?[WebServiceConstants.message.rawValue] as? String ?? "Something went wrong")
                }
                return

            }
            if let data = responseData {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let serverResponse  = try? decoder.decode(ServerRsponse.self, from: data)
                DispatchQueue.main.async {
                    success(serverResponse?.gitRepositories ?? [])
                }
                return
            }
        }
        task.resume()
    }
}

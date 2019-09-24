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
    
    private let gitRepositories:[GitRepositoryModel] = [GitRepositoryModel]()
    var page:Int = 0
    init(webService:WebService) {
        self.webService = webService
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


extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseRepositories(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<[GitRepositoryModel]>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

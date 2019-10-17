//
//  ServerResponse.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 17/10/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
class ServerRsponse: Decodable {
    var totalCount: Int!
    var incompleteResults: Bool!
    var gitRepositories: [GitRepositoryModel]!
    enum CodingKeys: String, CodingKey {
        case gitRepositories = "items"
        case totalCount
        case incompleteResults
    }
    required public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            gitRepositories = try container.decode([GitRepositoryModel].self, forKey: .gitRepositories)
            totalCount = try container.decode(Int.self, forKey: .totalCount)
            incompleteResults = try container.decode(Bool.self, forKey: .incompleteResults)
        } catch {
            assertionFailure("ERROR: \(error)")
        }
    }

}

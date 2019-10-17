//
//  GitRepository.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
class GitRepositoryModel: Codable {
    var name: String!
    var description: String!
    var url: String!
    var stars: Int!
    var owner: OwnerModel!
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case owner
        case stars = "stargazersCount"
        case url = "htmlUrl"
    }
    init(name: String,
         description: String,
         url: String,
         stars: Int,
         owner: OwnerModel) {
        self.name = name
        self.description = description
        self.url = url
        self.stars = stars
        self.owner = owner
    }

}

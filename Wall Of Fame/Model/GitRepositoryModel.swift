//
//  GitRepository.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
class GitRepositoryModel:Codable{
    let name:String
    let description:String
    let url:String
    let stars:Int
    let owner:OwnerModel
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case url = "url"
        case stars = "stargazers_Count"
        case owner = "owner"
    }
    init(name:String, description:String, url:String, stars:Int, owner:OwnerModel) {
        self.name = name
        self.description = description
        self.url = url
        self.stars = stars
        self.owner = owner
    }

}

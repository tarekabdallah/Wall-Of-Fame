//
//  GitRepository.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
import ObjectMapper
class GitRepositoryModel:Mappable{
    
    var name:String!
    var description:String!
    var url:String!
    var stars:Int!
    var owner:OwnerModel!
    
    required init?(map: Map) {
    }

    func mapping(map: Map) {
        name        <- map["name"]
        description <- map["description"]
        url         <- map["html_url"]
        stars       <- map["stargazers_count"]
        owner       <- map["owner"]

    }

    init(name:String, description:String, url:String, stars:Int, owner:OwnerModel) {
        self.name = name
        self.description = description
        self.url = url
        self.stars = stars
        self.owner = owner
    }

    
}

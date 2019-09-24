//
//  OwnerModel.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
import ObjectMapper
class OwnerModel:Mappable{
    
    var name:String!
    var id:Int!
    var avatar:String!
    var accountURL:String!
    required init?(map: Map) {
    }

     func mapping(map: Map) {
        name        <- map["login"]
        id          <- map["id"]
        avatar      <- map["avatar_url"]
        accountURL  <- map["html_url"]
    }

    init(name:String, id:Int, avatar:String, accountURL:String) {
        self.name = name
        self.id = id
        self.avatar = avatar
        self.accountURL = accountURL
    }
}

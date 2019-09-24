//
//  OwnerModel.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
class OwnerModel:Codable{
    let name:String
    let id:Int
    let avatar:String
    let accountURL:String

    enum CodingKeys: String, CodingKey {
        case name = "login"
        case id = "id"
        case avatar = "avatar_url"
        case accountURL = "html_url"
    }
    
    init(name:String, id:Int, avatar:String, accountURL:String) {
        self.name = name
        self.id = id
        self.avatar = avatar
        self.accountURL = accountURL
    }
}

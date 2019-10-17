//
//  OwnerModel.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
class OwnerModel: Codable {
    var name: String!
    var id: Int!
    var avatar: String!
    var accountUrl: String!
    init(name: String,
         id: Int,
         avatar: String,
         accountURL: String) {
        self.name = name
        self.id = id
        self.avatar = avatar
        self.accountUrl = accountURL
    }
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatar = "avatarUrl"
        case accountUrl = "htmlUrl"
        case id
    }
}

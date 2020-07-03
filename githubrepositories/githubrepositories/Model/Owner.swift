//
//  Owner.swift
//  githubrepositories
//
//  Created by Anderson Vieira on 01/07/20.
//  Copyright © 2020 Vieira. All rights reserved.
//

import Foundation

struct Owner: Codable {
    let login: String
    let avatar: URL
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatar = "avatar_url"
    }
}

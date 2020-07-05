//
//  Repository.swift
//  githubrepositories
//
//  Created by Anderson Vieira on 01/07/20.
//  Copyright © 2020 Vieira. All rights reserved.
//

import Foundation

struct Repository: Codable {
    let name: String
    let stars: UInt
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case stars = "stargazers_count"
        case owner = "owner"
    }
    
    
}

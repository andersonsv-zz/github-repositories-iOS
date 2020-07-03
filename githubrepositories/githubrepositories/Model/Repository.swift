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
    let image: URL
    let owner: Owner
}

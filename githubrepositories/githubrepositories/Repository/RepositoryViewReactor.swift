//
//  RepositoryViewModel.swift
//  githubrepositories
//
//  Created by Anderson Vieira on 04/07/20.
//  Copyright © 2020 Vieira. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

class RepositoryViewReactor: Reactor {
    
    enum Action {
        case updateQuery(String?)
        case loadNextPage
    }
    
    enum Mutation {
        case setQuery(String?)
        case setRepos([String], nextPage: Int?)
        case appendRepos([String], nextPage: Int?)
        case setLoadingNextPage(Bool)
    }
    
    struct State {
        var query: String?
        var repos: [String] = []
        var nextPage: Int?
        var isLoadingNextPage: Bool = false
    }
    
    let initialState = State()
    
    
}

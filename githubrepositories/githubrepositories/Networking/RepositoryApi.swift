//
//  RepositoryApi.swift
//  githubrepositories
//
//  Created by Anderson Vieira on 01/07/20.
//  Copyright © 2020 Vieira. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RepositoryApiService {
    func searchRepos(withLanguage language: String, withSort sortBy: String, page: Int, perPage:Int) -> Observable<[Repository]>?
}

final class RepositoryApi: RepositoryApiService {
    func searchRepos(withLanguage language: String, withSort sort: String, page: Int, perPage: Int) -> Observable<[Repository]>? {
        guard let endpointURL = URL(string: "https://api.github.com/search/repositories?q=\(language)&sort\(sort)&page=\(page)&per_page\(perPage)") else { return nil }
        
        let request = URLRequest(url: endpointURL)
        return URLSession.shared.rx.data(request: request)
            .map { data -> [Repository] in
                guard let response = try? JSONDecoder().decode(RepositoryResponse.self, from: data) else { return [] }
                return response.items
        }
    }

}

fileprivate struct RepositoryResponse: Decodable {
    let items: [Repository]
}

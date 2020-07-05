//
//  RepositoryViewModel.swift
//  githubrepositories
//
//  Created by Anderson Vieira on 04/07/20.
//  Copyright © 2020 Vieira. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

class RepositoryViewModel {
    let api = RepositoryApi()
    let repositories : BehaviorRelay<[Repository]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    
    func search(language: String, sort: String, page: Int, perPage: Int) {
        guard !language.isEmpty, !sort.isEmpty else {
            self.repositories.accept([]);
            return
        }
        
        api.searchRepos(withLanguage: language, withSort: sort, page: page, perPage: perPage)?
            .subscribe(
                onNext: { [weak self] repositories in
                    self?.repositories.accept(repositories)
                },
                onError: { error in
                    print(error)
            }
        )
        .disposed(by: disposeBag)
    }
    
}

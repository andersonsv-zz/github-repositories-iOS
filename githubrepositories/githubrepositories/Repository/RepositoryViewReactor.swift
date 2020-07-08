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
import Foundation

class RepositoryViewReactor: Reactor {
    
    enum Action {
        case updateQuery
        case loadNextPage
      }

      enum Mutation {
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

      func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateQuery:
          return Observable.concat([
            // 2) call API and set repos (.setRepos)
            self.search(page: 1)
              // cancel previous request when the new `.updateQuery` action is fired
              .takeUntil(self.action.filter(Action.isUpdateQueryAction))
              .map { Mutation.setRepos($0, nextPage: $1) },
          ])

        case .loadNextPage:
          guard !self.currentState.isLoadingNextPage else { return Observable.empty() } // prevent from multiple requests
          guard let page = self.currentState.nextPage else { return Observable.empty() }
          return Observable.concat([
            // 1) set loading status to true
            Observable.just(Mutation.setLoadingNextPage(true)),

            // 2) call API and append repos
            self.search(page: page)
              .takeUntil(self.action.filter(Action.isUpdateQueryAction))
              .map { Mutation.appendRepos($0, nextPage: $1) },

            // 3) set loading status to false
            Observable.just(Mutation.setLoadingNextPage(false)),
          ])
        }
      }

      func reduce(state: State, mutation: Mutation) -> State {
        switch mutation {
        case let .setRepos(repos, nextPage):
          var newState = state
          newState.repos = repos
          newState.nextPage = nextPage
          return newState

        case let .appendRepos(repos, nextPage):
          var newState = state
          newState.repos.append(contentsOf: repos)
          newState.nextPage = nextPage
          return newState

        case let .setLoadingNextPage(isLoadingNextPage):
          var newState = state
          newState.isLoadingNextPage = isLoadingNextPage
          return newState
        }
      }

      private func url(page: Int) -> URL? {
        return URL(string: "https://api.github.com/search/repositories?q=swift&sort=stars&page=\(page)")
      }

      private func search(page: Int) -> Observable<(repos: [String], nextPage: Int?)> {
        let emptyResult: ([String], Int?) = ([], nil)
        guard let url = self.url(page: page) else { return .just(emptyResult) }
        return URLSession.shared.rx.json(url: url)
          .map { json -> ([String], Int?) in
            guard let dict = json as? [String: Any] else { return emptyResult }
            guard let items = dict["items"] as? [[String: Any]] else { return emptyResult }
            let repos = items.compactMap { $0["full_name"] as? String }
            let nextPage = repos.isEmpty ? nil : page + 1
            return (repos, nextPage)
          }
          .do(onError: { error in
            if case let .some(.httpRequestFailed(response, _)) = error as? RxCocoaURLError, response.statusCode == 403 {
              print("⚠️ GitHub API rate limit exceeded. Wait for 60 seconds and try again.")
            }
          })
          .catchErrorJustReturn(emptyResult)
      }
    }

    extension RepositoryViewReactor.Action {
      static func isUpdateQueryAction(_ action: RepositoryViewReactor.Action) -> Bool {
        if case .updateQuery = action {
          return true
        } else {
          return false
        }
      }
}

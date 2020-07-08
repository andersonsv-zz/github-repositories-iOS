//
//  ViewController.swift
//  githubrepositories
//
//  Created by Anderson Vieira on 01/07/20.
//  Copyright © 2020 Vieira. All rights reserved.
//
import UIKit
import ReactorKit
import RxCocoa
import RxSwift

class RepositoryViewController: UIViewController, StoryboardView {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        return refreshControl
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Private Functions
    
    private func setupView(){
        view.backgroundColor = .white
        tableView.addSubview(refreshControl)
        view.addSubview(tableView)
    }
    
    func bind(reactor: RepositoryViewReactor) {
        // Action
         Observable.just(Void())
        .map { Reactor.Action.updateQuery }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        
        //Refresh
        refreshControl.rx.controlEvent(.valueChanged).map { Reactor.Action.updateQuery }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        tableView.rx.contentOffset
            .filter { [weak self] offset in
                guard let `self` = self else { return false }
                guard self.tableView.frame.height > 0 else { return false }
                return offset.y + self.tableView.frame.height >= self.tableView.contentSize.height - 100
        }
        .map { _ in Reactor.Action.loadNextPage }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.repos }
            .bind(to: tableView.rx.items(cellIdentifier: "cell")) { indexPath, repo, cell in
                cell.textLabel?.text = repo
        }
        .disposed(by: disposeBag)
        
    }
}


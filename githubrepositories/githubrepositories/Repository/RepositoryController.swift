//
//  ViewController.swift
//  githubrepositories
//
//  Created by Anderson Vieira on 01/07/20.
//  Copyright © 2020 Vieira. All rights reserved.
//

import UIKit
import RxSwift

class RepositoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let disposeBag = DisposeBag()
    let viewModel: RepositoryViewModel = RepositoryViewModel()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupTableView()
        
        loadItems()
    }
    
    //MARK: - Private Functions
    private func loadItems(){
        self.viewModel.search(language: "swift", sort: "stars", page: 1, perPage: 10)
                 
               
       viewModel.repositories.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: "cell", cellType: RepositoryCell.self)) { index, model, cell in
           //cell.setupCell(model: model )
       }.disposed(by: disposeBag)
       
       /*tableView.rx.modelSelected(Repository.self)
           .subscribe(onNext: { repository in
               UIApplication.shared.open(repository.html_url, options:  [:], completionHandler: nil)
           })
           .disposed(by: disposeBag)*/
        
        
    }
    private func setupView(){
        view.backgroundColor = .white
        
        view.addSubview(tableView)
    }


    private func setupConstraints(){
        // Table View
        NSLayoutConstraint.activate([
           tableView.topAnchor.constraint(equalTo: view.saferAreaLayoutGuide.topAnchor, constant: 0),
           tableView.bottomAnchor.constraint(equalTo: view.saferAreaLayoutGuide.topAnchor, constant: 0),
           tableView.rightAnchor.constraint(equalTo: view.saferAreaLayoutGuide.rightAnchor, constant: 0),
           tableView.leftAnchor.constraint(equalTo: view.saferAreaLayoutGuide.leftAnchor, constant: 0)
       ])
    }
    
    private func setupTableView(){
        tableView.separatorStyle = .singleLine
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: "cell")
    }

    //MARK: Table View Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}


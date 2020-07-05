//
//  ViewController.swift
//  githubrepositories
//
//  Created by Anderson Vieira on 01/07/20.
//  Copyright © 2020 Vieira. All rights reserved.
//

import UIKit
import RxSwift

class RepositoryViewController: UIViewController {
    
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
    }
    
    //MARK: - Private Functions
    
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
        //tableView.register(RepositoryCell.self, forCellReuseIdentifier: "cell")
    }
}


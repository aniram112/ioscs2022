//
//  SearchController.swift
//  RickAndMorty
//
//  Created by Marina Roshchupkina on 09.05.2022.
//

import Foundation
import UIKit
import Kingfisher

final class SearchViewController: UIViewController{
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        setupTableView()
        setupUI()

    }
    
    private func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -50),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            
            tableView.topAnchor.constraint(equalTo: searchBar.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
            
        ])
                
    }
    
    private func setupTableView() {
        tableView.register(RecentCell.self, forCellReuseIdentifier: "RecentCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = true
    }
    
    
    private lazy var searchBar: UISearchBar = {
        let ret = UISearchBar()
        ret.searchBarStyle = UISearchBar.Style.default
        ret.placeholder = " Search..."
        ret.sizeToFit()
        ret.isTranslucent = false
        ret.backgroundImage = UIImage()
        ret.layer.cornerRadius = 10
        ret.layer.masksToBounds = true
        ret.contentMode = .scaleAspectFill
        return ret
    }()
    
    private lazy var tableView: UITableView = {
        let ret = UITableView()
        ret.backgroundColor = UIColor.white
        ret.layer.cornerRadius = 10
        ret.rowHeight = 250
        ret.layer.masksToBounds = true
        ret.contentMode = .scaleAspectFill
        ret.separatorColor = .white
        return ret
    }()
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection
                    section: Int) -> Int {
        1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:
                    IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "RecentCell",
            for: indexPath
        ) as? RecentCell
        //cell?.setupEye()
        return cell ?? UITableViewCell()
    }
}

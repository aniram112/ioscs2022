//
//  FavoritesViewController.swift
//  RickAndMorty
//
//  Created by Marina Roshchupkina on 09.05.2022.
//

import UIKit
import Kingfisher

final class FavoritesViewController: UIViewController{
    
    var imageURLs : [URL?]!
    
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
        imageURLs = [URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
                     URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"),
                     URL(string: "https://rickandmortyapi.com/api/character/avatar/3.jpeg"),
                     URL(string: "https://rickandmortyapi.com/api/character/avatar/4.jpeg"),
                     URL(string: "https://rickandmortyapi.com/api/character/avatar/5.jpeg"),
                     URL(string: "https://rickandmortyapi.com/api/character/avatar/6.jpeg"),
        ]
        //searchBar.delegate = self
        
        // с large navigation title не вышло
        label.text = "Favorites"
        setupTableView()
        setupUI()

    }
    
    private func setupUI() {
        view.addSubview(label)
        view.addSubview(tableView)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5),
            
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
            
        ])
                
    }
    
    private func setupTableView() {
        tableView.register(CharacterCell.self, forCellReuseIdentifier: "CharacterCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = true
    }
    
    private lazy var label: UILabel = {
        let ret = UILabel()
        ret.font = .largeTitleBold
        ret.numberOfLines = 1
        ret.textColor = .main
        return ret
    }()
    
    
    private lazy var tableView: UITableView = {
        let ret = UITableView()
        ret.backgroundColor = UIColor.white
        ret.layer.cornerRadius = 10
        ret.rowHeight = 180
        ret.layer.masksToBounds = true
        ret.contentMode = .scaleAspectFill
        
        return ret
    }()
    
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection
                    section: Int) -> Int {
        imageURLs.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = CharacterViewController.Model(
            cellModel: [.init(key: "Status:", value: "Value"),.init(key: "Species:", value: "Value"),.init(key: "Gender:", value: "Value")],
            name: "Character Name",
            imageURL:  imageURLs[indexPath.row] ?? URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
        )
        let Character = CharacterViewController(model: model)
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController!.pushViewController(Character, animated: true)
        
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:
                    IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CharacterCell",
            for: indexPath
        ) as! CharacterCell
        cell.icon.kf.setImage(with: imageURLs[indexPath.row])
        return cell
    }
}


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
        view.backgroundColor = .customWhite
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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            // this one worked the best
            navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupUI() {
        view.addSubview(label)
        view.addSubview(tableView)
        view.backgroundColor = .customWhite
        tableView.backgroundColor = .customWhite
        
        label.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor,constant: 66),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            
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
        ret.textColor = .customBlack
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

public func getCharacter(id: Int) async throws {
    
    guard let url = URL(string: "https://rickandmortyapi.com/api/character/"+String(id)) else { fatalError("Missing URL") }
    let urlRequest = URLRequest(url: url)
    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
    let character = try JSONDecoder().decode(Character.self, from: data)
    print("Async character", character)
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection
                   section: Int) -> Int {
        Storage.shared.favCharacters.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CharacterCell
        let character = Storage.shared.favCharacters[indexPath.row]
        /*Task{
         do{
         try await getCharacter(id: indexPath.row+1)
         }
         catch{
         appLogger.logger.log(level: .error, message: "async error")
         }
         }*/
        
        let model = CharacterViewController.Model(
            cellModel: [.init(key: "Status:", value: character.status),.init(key: "Species:", value: character.species),.init(key: "Gender:", value: character.gender)],
            name: character.name,
            image: cell.icon.image ?? UIImage(),
            character: character
        )
        let Character = CharacterViewController(model: model)
        appLogger.logger.log(level: .info, message: "opening character")
        
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
        cell.label.text = Storage.shared.favCharacters[indexPath.row].name
        cell.icon.image = Storage.shared.favImages[indexPath.row]
        return cell
    }
}


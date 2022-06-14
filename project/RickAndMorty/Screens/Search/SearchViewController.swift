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
    
    let search = UISearchController()
    internal var characters:[Character] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        search.isActive = true
        super.viewWillAppear(false)
        tableView.register(RecentCell.self, forCellReuseIdentifier: "RecentCell")
        characters = []
        //self.definesPresentationContext = true
        
        
        //characters = []
        //tabBarController?.navigationItem.searchController?.isActive = true
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.definesPresentationContext = true
        view.backgroundColor = .customWhite
        //tabBarController?.navigationItem.searchController = search
        search.searchResultsUpdater = self
        search.automaticallyShowsCancelButton = false
        //search.obscuresBackgroundDuringPresentation = false
        //navigationItem.searchController = search
        
        tableView.tableHeaderView = search.searchBar
        
        self.hideKeyboardWhenTappedAround()
        setupTableView()
        setupUI()
        setupSearchBar()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        //search.searchBar.removeFromSuperview()
        //self.definesPresentationContext = false
        super.viewWillDisappear(false)
        search.isActive = false
        
        //tabBarController?.navigationItem.searchController?.isActive = false
        //self.dismiss(animated: false, completion: nil)
    }
    
    
    private func setupUI() {
        view.addSubview(tableView)
        //view.addSubview(search.searchBar)
        
        //search.searchBar.translatesAutoresizingMaskIntoConstraints = false
        search.searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            //search.searchBar.centerXAnchor.constraint(equalTo: tableView.tableHeaderView!.centerXAnchor),
            //search.searchBar.widthAnchor.constraint(equalTo: tableView.tableHeaderView!.widthAnchor,constant: -50),
            //search.searchBar.topAnchor.constraint(equalTo: tableView.tableHeaderView!.topAnchor, constant: 0),
            search.searchBar.searchTextField.heightAnchor.constraint(equalToConstant: 50),
            //search.searchBar.searchTextField.widthAnchor.constraint(equalToConstant: 350),
            search.searchBar.searchTextField.centerXAnchor.constraint(equalTo: tableView.tableHeaderView!.centerXAnchor),
            search.searchBar.searchTextField.widthAnchor.constraint(equalTo: tableView.tableHeaderView!.widthAnchor,constant: -20),
            //tableView.topAnchor.constraint(equalTo: search.searchBar.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
            
        ])
        
        //tableView.reloadData()
        
    }
    
    private func setupTableView() {
        //tableView.register(RecentCell.self, forCellReuseIdentifier: "RecentCell")
        tableView.register(CharacterSearchCell.self, forCellReuseIdentifier: "SearchCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = true
    }
    
    private func setupSearchBar() {
        search.searchBar.searchBarStyle = UISearchBar.Style.minimal
        search.searchBar.barTintColor = .white
        search.searchBar.searchTextField.layer.borderColor = (UIColor.black).cgColor
        search.searchBar.searchTextField.layer.borderWidth = 1.0
        search.searchBar.searchTextField.layer.cornerRadius = 10
        search.searchBar.searchTextField.backgroundColor = .white
        search.searchBar.placeholder = " Search for character"
        search.searchBar.searchTextField.leftView?.tintColor = .black
        //search.searchBar.sizeToFit()
        search.searchBar.isTranslucent = false
        search.searchBar.backgroundImage = UIImage()
        search.searchBar.layer.cornerRadius = 10
        search.searchBar.layer.masksToBounds = true
        search.searchBar.contentMode = .center
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.search.searchBar.endEditing(true)
        //self.search.searchBar.isHidden = true
    }
    
    
    private lazy var tableView: UITableView = {
        let ret = UITableView()
        let HEADER_HEIGHT = 100
        ret.tableHeaderView?.frame.size = CGSize(width: ret.frame.width, height: CGFloat(HEADER_HEIGHT))
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
        if characters.count == 0 {return 1}
        return characters.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CharacterSearchCell
        
        let model = CharacterViewController.Model(
            cellModel: [.init(key: "Status:", value: characters[indexPath.row].status),.init(key: "Species:", value: characters[indexPath.row].species),.init(key: "Gender:", value: characters[indexPath.row].gender)],
            name: characters[indexPath.row].name,
            image: cell.icon.image ?? UIImage(),
            character: characters[indexPath.row]
        )
        let Character = CharacterViewController(model: model)
        appLogger.logger.log(level: .info, message: "opening character")
        
        if let index = Storage.shared.searchHistory.firstIndex(of: characters[indexPath.row] ) {
            Storage.shared.searchHistory.remove(at: index)
        }
        Storage.shared.searchHistory.insert(characters[indexPath.row], at: 0)
        //Storage.shared.searchHistory.append(characters[indexPath.row])
        //Storage.shared.searchHistory.reverse()
        
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController!.pushViewController(Character, animated: true)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:
                   IndexPath) -> UITableViewCell {
        
        self.tableView.register(RecentCell.self, forCellReuseIdentifier: "RecentCell")
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "RecentCell",
            for: indexPath
        ) as? RecentCell
        cell?.myParent = self
        if (characters.count != 0){
            self.tableView.register(CharacterSearchCell.self, forCellReuseIdentifier: "SearchCell")
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "SearchCell",
                for: indexPath
            ) as? CharacterSearchCell
            cell?.label.text = characters[indexPath.row].name
            let url = characters[indexPath.row].image
            //cell?.icon.kf.setImage(with: URL(string: characters[indexPath.row].image))
            Task{
                do{
                    try await cell?.icon.image = getImage(url: url)
                }
                catch{
                    appLogger.logger.log(level: .error, message: "async downloading image error")
                    print("Request failed with error: \(error)")
                }
            }
            return cell ?? UITableViewCell()
        }
        //cell?.icon = characters[indexPath.row].image
        return cell ?? UITableViewCell()
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = search.searchBar.text, !text.isEmpty else {
            return
        }
        Task{
            do{
                try await self.getByName(Name: text)
            }
            catch{
                appLogger.logger.log(level: .error, message: "async search error")
                print("Request failed with error: \(error)")
            }
        }
        //tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Task{
            do{
                try await self.getByName(Name: searchText)
            }
            catch{
                appLogger.logger.log(level: .error, message: "async search error")
                print("Request failed with error: \(error)")
            }
        }
        //tableView.reloadData()
    }
    
    public func getByName(Name: String) async throws{
        
        var urlString = Name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?name="+urlString!) else {return}
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {return}
        
        let chars = try JSONDecoder().decode(Characters.self, from: data)
        self.characters = chars.results
        
        //print("Async characters\n", chars.results)
        //return characters.result
    }
    
}

public func getImage(url: String) async throws -> UIImage{
    
    guard let url = URL(string: url) else {return UIImage()}
    let urlRequest = URLRequest(url: url)
    
    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {return UIImage()}
    
    let img =  UIImage(data: data) ?? UIImage()
    return img
}



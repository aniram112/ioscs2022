//
//  RecentCell.swift
//  RickAndMorty
//
//  Created by Marina Roshchupkina on 09.05.2022.
//

import UIKit
// модель с массивом картинок персонажа (кликабельно?)
class RecentCell: UITableViewCell {
    
    weak var myParent:SearchViewController?
    var imageURLs : [URL?]!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = .white
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        /*imageURLs = [URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
                     URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"),
                     URL(string: "https://rickandmortyapi.com/api/character/avatar/3.jpeg"),
                     URL(string: "https://rickandmortyapi.com/api/character/avatar/4.jpeg"),
                     URL(string: "https://rickandmortyapi.com/api/character/avatar/5.jpeg"),
                     URL(string: "https://rickandmortyapi.com/api/character/avatar/6.jpeg"),
        ]*/
        label.text = "Recent"
        setupUI()
        
    }
    
    private func setupUI() {
        addSubview(label)
        contentView.addSubview(collectionView) // иначе скролл не работает
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 5),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var label: UILabel = {
        let ret = UILabel()
        ret.font = .body
        ret.numberOfLines = 1
        ret.textColor = .customWhite
        return ret
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        
        let ret = UICollectionView(frame: frame, collectionViewLayout: layout)
        ret.backgroundColor = UIColor.white
        ret.showsHorizontalScrollIndicator = false
        ret.layer.cornerRadius = 0
        ret.layer.masksToBounds = true
        ret.contentMode = .scaleAspectFill
        
        return ret
    }()
}
extension RecentCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return imageURLs.count
        return Storage.shared.searchHistory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        //myCell.Image.kf.setImage(with: imageURLs[indexPath.row])
        Task{
            do{
                try await myCell.Image.image = getImage(url: Storage.shared.searchHistory[indexPath.row].image)
            }
            catch{
                appLogger.logger.log(level: .error, message: "async downloading image error")
                print("Request failed with error: \(error)")
            }
        }
        
        return myCell
    }
}
extension RecentCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        let char = Storage.shared.searchHistory[indexPath.row]
        
        let model = CharacterViewController.Model(
            cellModel: [.init(key: "Status:", value: char.status),.init(key: "Species:", value: char.species),.init(key: "Gender:", value: char.gender)],
            name: char.name,
            image: cell.Image.image ?? UIImage(),
            character: char
        )
        let Character = CharacterViewController(model: model)
        appLogger.logger.log(level: .info, message: "opening character")
        
        if let index = Storage.shared.searchHistory.firstIndex(of: char ) {
            Storage.shared.searchHistory.remove(at: index)
        }
        Storage.shared.searchHistory.insert(char, at: 0)
        //Storage.shared.searchHistory.reverse()
        collectionView.reloadData()
        myParent?.navigationController?.modalPresentationStyle = .fullScreen
        myParent?.navigationController!.pushViewController(Character, animated: true)
    }
}




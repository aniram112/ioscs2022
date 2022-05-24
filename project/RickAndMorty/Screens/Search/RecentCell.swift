//
//  RecentCell.swift
//  RickAndMorty
//
//  Created by Marina Roshchupkina on 09.05.2022.
//

import Foundation
import UIKit
// модель с массивом картинок персонажа (кликабельно?)
class RecentCell: UITableViewCell {
    
    var imageURLs : [URL?]!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = .white
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        imageURLs = [URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
                     URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"),
                     URL(string: "https://rickandmortyapi.com/api/character/avatar/3.jpeg"),
                     URL(string: "https://rickandmortyapi.com/api/character/avatar/4.jpeg"),
                     URL(string: "https://rickandmortyapi.com/api/character/avatar/5.jpeg"),
                     URL(string: "https://rickandmortyapi.com/api/character/avatar/6.jpeg"),
        ]
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
        ret.textColor = .main
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
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        myCell.Image.kf.setImage(with: imageURLs[indexPath.row])
        
        return myCell
    }
}
extension RecentCell: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
}




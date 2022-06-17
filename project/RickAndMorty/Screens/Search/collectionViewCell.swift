//
//  collectionViewCell.swift
//  RickAndMorty
//
//  Created by Marina Roshchupkina on 09.05.2022.
//

import UIKit
class ImageCell : UICollectionViewCell{
    var Image : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    
        self.Image = UIImageView()
        backgroundColor = UIColor.white
        layer.cornerRadius = 10
        addSubview(Image)
        Image.autoresizingMask = self.autoresizingMask
        Image.translatesAutoresizingMaskIntoConstraints = false
        Image.image = UIImage()
        Image.layer.cornerRadius = 10
        Image.layer.borderWidth = 1.0
        Image.layer.borderColor = (UIColor.black).cgColor
        Image.layer.masksToBounds = true
        Image.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            Image.topAnchor.constraint(equalTo: topAnchor),
            Image.bottomAnchor.constraint(equalTo: bottomAnchor),
            Image.centerXAnchor.constraint(equalTo: centerXAnchor),
            Image.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    struct Model {
        var url: URL
    }
    
    func update(with model: Model) {
        // Cancel current task
        task?.cancel()
        
        // Start a new task
        task = Task {
            let character = characterProvider.requestCharacter(with: model.url)
            
            if Task.isCancelled {
                return
            }
            
            update(with: character)
        }
    }
    
    private var task: Task<Void, Never>?
    
    private func update(with character: Character) {
        // Update state
    }
}

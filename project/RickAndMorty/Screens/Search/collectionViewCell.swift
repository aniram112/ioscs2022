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
    
    
    func update(with imageURL: String) {
        // Cancel current task
        task?.cancel()
        
        // Start a new task
        task = Task {
            let url = imageURL
            
            if Task.isCancelled {
                return
            }
            
            updateImage(with: url)
        }
    }
    
    private var task: Task<Void, Never>?
    
    private func updateImage(with url: String)  {
        Task{
            do{
                try await Image.image = getImage(url: String(url))
            }
            catch {
                appLogger.logger.log(level: .error, message: "async downloading image error")
                print("Request failed with error: \(error)")
            }
        }
    }
}

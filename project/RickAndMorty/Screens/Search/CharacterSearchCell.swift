//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Marina Roshchupkina on 09.05.2022.
//

import UIKit
class CharacterSearchCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = .customWhite
        //backgroundColor = .cyan
        label.text = "Character Name"
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        addSubview(label)
        addSubview(icon)
        label.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 150),
            icon.heightAnchor.constraint(equalToConstant: 150),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            
            label.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor,constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    
    
    lazy var icon: UIImageView = {
        let ret = UIImageView()
        ret.layer.borderWidth = 1.0
        ret.layer.borderColor = (UIColor.black).cgColor
        ret.layer.cornerRadius = 10
        ret.layer.masksToBounds = true
        ret.contentMode = .scaleAspectFill
        return ret
    }()
    
    
    lazy var label: UILabel = {
        let ret = UILabel()
        ret.font = .title2
        ret.numberOfLines = 3
        ret.contentMode = .scaleToFill
        ret.textColor = .customBlack
        return ret
    }()
}


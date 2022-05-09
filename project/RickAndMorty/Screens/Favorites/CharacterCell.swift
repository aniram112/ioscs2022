//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Marina Roshchupkina on 09.05.2022.
//

import UIKit
class CharacterCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = .white
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
            icon.widthAnchor.constraint(equalToConstant: 120),
            icon.heightAnchor.constraint(equalToConstant: 120),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            
            label.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor,constant: 20)
        ])
    }
    
    
    
    lazy var icon: UIImageView = {
        let ret = UIImageView()
        ret.layer.cornerRadius = 10
        ret.layer.masksToBounds = true
        ret.contentMode = .scaleAspectFill
        return ret
    }()
    
    
    private lazy var label: UILabel = {
        let ret = UILabel()
        ret.font = .boldSystemFont(ofSize: 20)
        ret.numberOfLines = 1
        ret.textColor = .main
        return ret
    }()
}

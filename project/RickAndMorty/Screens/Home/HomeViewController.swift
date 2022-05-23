//
//  HomeViewController.swift
//  RickAndMorty
//
//  Created by Marina Roshchupkina on 17.05.2022.
//

import UIKit
final class HomeViewController: UIViewController, UINavigationControllerDelegate{
    
    
    let bigTitle = UILabel()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        self.navigationController?.delegate = self
        super.viewDidLoad()
        view.backgroundColor = .white
        bigTitle.attributedText = NSMutableAttributedString(string: "RICK AND MORTY", attributes: strokeTextAttributes)
        smallTitle.text = "CHARACTER BOOK"
        smallTitle.addCharacterSpacing(kernValue: 3)
        smallPicture.image = UIImage(named: "smallpicture")
        
        smallPicture.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.openNew(_:)))
        smallPicture.addGestureRecognizer(tap)
        
        setupUI()
    }
    
    @objc func openNew(_ sender: UITapGestureRecognizer? = nil) {
        let bp = BigPictureViewController()
        print("tapped")
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(bp, animated: false)
        //self.present(navigationController, animated: true, completion: nil)
    }
    
    private func setupUI() {
        view.addSubview(bigTitle)
        view.addSubview(smallTitle)
        view.addSubview(smallPicture)
        
        bigTitle.translatesAutoresizingMaskIntoConstraints = false
        bigTitle.lineBreakMode = .byWordWrapping
        bigTitle.numberOfLines = 3
        smallTitle.translatesAutoresizingMaskIntoConstraints = false
        smallPicture.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bigTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bigTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            bigTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            
            // по макету 24, но там высота линини 86 при шрифте 72 так что я добавила 14 сюда
            smallTitle.topAnchor.constraint(equalTo: bigTitle.bottomAnchor,constant: 38),
            smallTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            smallTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -70),
            
            smallPicture.heightAnchor.constraint(equalToConstant: 222),
            smallPicture.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -32),
            smallPicture.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            smallPicture.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            
        ])
        
    }
    
    private lazy var smallTitle: UILabel = {
        let ret = UILabel()
        ret.font = .largeTitleBlack
        ret.numberOfLines = 1
        ret.textColor = .black
        ret.lineBreakMode = .byWordWrapping
        ret.numberOfLines = 2
        return ret
    }()
    
    private lazy var smallPicture: UIImageView = {
        let ret = UIImageView()
        ret.layer.masksToBounds = true
        //ret.contentMode = .scaleAspectFill
        return ret
    }()
    
    
    let strokeTextAttributes = [
        NSAttributedString.Key.strokeColor : UIColor.black,
        NSAttributedString.Key.foregroundColor : UIColor.white,
        NSAttributedString.Key.strokeWidth : -1.0,
        NSAttributedString.Key.kern : 3,
        NSAttributedString.Key.font : UIFont.largeTitleWhite as Any]
    
    as [NSAttributedString.Key : Any]
    
}


extension UILabel {
    // adding space between each characters
    func addCharacterSpacing(kernValue: Double = 3) {
        if let labelText = text, labelText.isEmpty == false {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(.kern,
                                          value: kernValue,
                                          range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}


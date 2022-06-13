//
//  RootViewController.swift
//  RickAndMorty
//
//  Created by Marina Roshchupkina on 11.05.2022.
//

import UIKit
final class RootViewController: UITabBarController, UITabBarControllerDelegate{
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 83
        tabBar.frame.origin.y = view.frame.height - 83
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.backgroundColor = .customWhite
        self.tabBar.tintColor = .customBlack
        //self.navigationController?.navigationBar.tintColor = .black
        
        
        
        let tabOne = HomeViewController()
        let tabOneBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        //tabOneBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        tabOne.tabBarItem = tabOneBarItem
        //tabOne.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        let tabTwo = FavoritesViewController()
        let tabTwoBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart")?.withAlignmentRectInsets(UIEdgeInsets(top: 8.5, left: 0, bottom: -8.5, right: 0)), selectedImage: UIImage(systemName: "heart.fill")?.withAlignmentRectInsets(UIEdgeInsets(top: 8.5, left: 0, bottom: -8.5, right: 0)))
        tabTwo.tabBarItem = tabTwoBarItem
        //tabTwo.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        
        let tabThree = SearchViewController()
        let tabThreeBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        tabThree.tabBarItem = tabThreeBarItem
        //tabThree.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        self.viewControllers = [tabOne,tabTwo,tabThree]
        
    }
    
    
    
    func createCharacter(model: CharacterViewController.Model) -> CharacterViewController{
        return CharacterViewController(model: model)
    }
    
}



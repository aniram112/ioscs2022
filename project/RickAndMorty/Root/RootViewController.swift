//
//  RootViewController.swift
//  RickAndMorty
//
//  Created by Marina Roshchupkina on 11.05.2022.
//

import UIKit
final class RootViewController: UITabBarController, UITabBarControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let model = CharacterViewController.Model(
            cellModel: [.init(key: "Status:", value: "Value"),.init(key: "Species:", value: "Value"),.init(key: "Gender:", value: "Value")],
            name: "Rick",
            imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!
        )
        
        let tabOne = createCharacter(model: model)
        let tabOneBarItem = UITabBarItem(title: model.name, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo = FavoritesViewController()
        let tabTwoBarItem = UITabBarItem(title: "favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        tabTwo.tabBarItem = tabTwoBarItem
        
        let tabThree = SearchViewController()
        let tabThreeBarItem = UITabBarItem(title: "search", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        tabThree.tabBarItem = tabThreeBarItem
        
        self.viewControllers = [tabOne,tabTwo,tabThree]
        
    }

    
    func createCharacter(model: CharacterViewController.Model) -> CharacterViewController{
        return CharacterViewController(model: model)
    }
    
}


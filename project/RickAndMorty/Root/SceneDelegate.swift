//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Alexander Shchavrovskiy on 22.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        /*let model = CharacterViewController.Model(
            cellModel: [.init(key: "Status:", value: "Value"),.init(key: "Species:", value: "Value"),.init(key: "Gender:", value: "Value")],
            name: "Rick",
            imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!
        )*/
        //let navigationController = UINavigationController(rootViewController: CharacterViewController(model: model))
        //let navigationController = UINavigationController(rootViewController: SearchViewController())
        //let navigationController = UINavigationController(rootViewController: FavoritesViewController())
        
        
        Storage.shared.getFavs()
        Storage.shared.getImages()
        let tabBarController = RootViewController()
        let navigationController = UINavigationController(rootViewController: tabBarController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}


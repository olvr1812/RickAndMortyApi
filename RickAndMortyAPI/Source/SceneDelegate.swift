//
//  SceneDelegate.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 15.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let rootVC = CharactersVC()
        rootVC.navigationItem.title = "Rick & Morti API"

        let navController = self.configuredNavigationController
        navController.viewControllers = [rootVC]

        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

    private lazy var configuredNavigationController: UINavigationController = {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.black
        navVC.navigationBar.backgroundColor = .clear
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }()
}

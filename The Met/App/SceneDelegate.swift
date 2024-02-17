//
//  SceneDelegate.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let launchVC = LaunchViewController()
        let navigationController = UINavigationController(rootViewController: launchVC)

        let launchAssembler = LaunchAssembler(navigationController: navigationController)
        launchAssembler.configure(viewController: launchVC)

//        let tabBar = UITabBarController()
//        let randomArtScreen = RandomArtViewController()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
    }
}

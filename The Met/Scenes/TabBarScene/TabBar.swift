//
//  TabBar.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

// MARK: - TabBarController
final class TabBar: UITabBarController {

    // MARK: - Private properties
    private let networkManager = NetworkManager.shared

    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
}

// MARK: - Setup UI of tab bar
private extension TabBar {

    func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .tabBarBackground

        tabBar.items?[0].image = UIImage(systemName: "photo")
        tabBar.items?[1].image = UIImage(systemName: "photo.stack")

        let tabBarItemAppearance = UITabBarItemAppearance()

        tabBarItemAppearance.normal.iconColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1).withAlphaComponent(0.5)
        tabBar.tintColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)

        tabBarItemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1).withAlphaComponent(0.5),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
        ]

        tabBarItemAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
        ]

        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}

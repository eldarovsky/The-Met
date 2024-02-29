//
//  TabBar.swift
//  The Met
//
//  Created by Eldar Abdullin on 01.01.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
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
        tabBarAppearance.backgroundColor = .backgroundTabBar

        tabBar.items?[0].image = UIImage(systemName: "photo")
        tabBar.items?[1].image = UIImage(systemName: "photo.stack")

        let tabBarItemAppearance = UITabBarItemAppearance()

        tabBarItemAppearance.normal.iconColor = .customGrayLight
        tabBar.tintColor = .customGray

        tabBarItemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.customGrayLight,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
        ]

        tabBarItemAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.customGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
        ]

        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}

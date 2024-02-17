//
//  TabBar.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

//final class TabBar {
//    private let navigationController: UINavigationController
//
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//}
//
//extension TabBar: BaseAssembly {
//    func configure(viewController: UIViewController) {
//        guard let tabBarController = viewController as? ITabBarController else { return }
//
//        // Добавьте настройку ваших сцен для таббара
//        let scene2VC = Scene2ViewController()
//        let scene3VC = Scene3ViewController()
//
//        let navController2 = UINavigationController(rootViewController: scene2VC)
//        let navController3 = UINavigationController(rootViewController: scene3VC)
//
//        scene2VC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
//        scene3VC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
//
//        tabBarController.viewControllers = [navController2, navController3]
//    }
//}

import UIKit



// MARK: - TabBarController
final class TabBar: UITabBarController {

    // MARK: - Private properties
    private let networkManager = NetworkManager.shared

    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchDepartmentsIDs()
        setupTabBar()
    }

    // MARK: - Private methods
//    private func fetchDepartmentsIDs() {
//        networkManager.fetchObjects(Departments.self, from: Link.departmentsURL) { [weak self] result in
//            switch result {
//            case .success(let departments):
//                guard let viewControllers = self?.viewControllers else { return }
//
//                viewControllers.forEach { viewController in
//                    guard let navigationVC = viewController as? DepartmentsNavigationController else { return }
//
//                    DispatchQueue.main.async {
//                        if let departmentsVC = navigationVC.topViewController as? DepartmentsViewController {
//                            departmentsVC.departments = departments
//                        }
//                    }
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//
//                DispatchQueue.main.async {
//                    guard let self = self else { return }
//                    self.networkManager.alertAction(fromVC: self)
//                }
//            }
//        }
//    }
}

// MARK: - Setup UI of tab bar
private extension TabBar {

    func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(red: 159/255, green: 166/255, blue: 151/255, alpha: 1)

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

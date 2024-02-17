//
//  LaunchRouter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

protocol ILaunchRouter: BaseRouting {

}

final class LaunchRouter {
    enum Target {
        case tabBar
    }

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension LaunchRouter: ILaunchRouter {
    func routeTo(target: Any) {
        guard let target = target as? LaunchRouter.Target else { return }

        switch target {
        case .tabBar:
            let randomArtVC = RandomArtViewController()
            let randomArtAssembly = RandomArtAssembler(navigationController: navigationController)
            randomArtAssembly.configure(viewController: randomArtVC)

            let departmentsVC = DepartmentsViewController()

//            let tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)

            // Если таббар контроллер уже существует, добавляем RandomArtViewController к нему
            if let tabBarController = navigationController.tabBarController {
                var viewControllers = tabBarController.viewControllers ?? []
                viewControllers.append(randomArtVC)
                viewControllers.append(departmentsVC)
                tabBarController.viewControllers = viewControllers
            } else {
                // Иначе создаем новый таббар контроллер и делаем его rootViewController
                let tabBarController = UITabBarController()
                tabBarController.viewControllers = [randomArtVC, departmentsVC]

                tabBarController.tabBar.items?.first?.title = "Random"
                tabBarController.tabBar.items?.first?.image = UIImage(systemName: "photo")

                tabBarController.tabBar.items?.last?.title = "Departments"
                tabBarController.tabBar.items?.last?.image = UIImage(systemName: "photo.stack")

//                navigationController.setViewControllers([tabBarController], animated: true)
                navigationController.present(tabBarController, animated: true)
                navigationController.modalPresentationStyle = .fullScreen
            }
        }
    }
}

//
//  LaunchRouter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

protocol LaunchRouterProtocol: BaseRouting {}

final class LaunchRouter {
    enum Target {
        case tabBar(imageIDs: [Int])
    }

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension LaunchRouter: LaunchRouterProtocol {
    func routeTo(target: Any) {
        guard let target = target as? LaunchRouter.Target else { return }

        switch target {
        case .tabBar (let imageIDs):
            let randomArtVC = RandomArtViewController()
            let randomArtNavigationController = UINavigationController(rootViewController: randomArtVC)
            let randomArtAssembler = RandomArtAssembler(navigationController: randomArtNavigationController, imageIDs: imageIDs)
            randomArtAssembler.configure(viewController: randomArtVC)

            let departmentsVC = DepartmentsViewController()
            let departmentsNavigationController = UINavigationController(rootViewController: departmentsVC)
            let departmentsAssembler = DepartmentsAssembler(navigationController: departmentsNavigationController)
            departmentsAssembler.configure(viewController: departmentsVC)

            let tabBarController = TabBar()
            tabBarController.viewControllers = [randomArtNavigationController, departmentsNavigationController]

            tabBarController.tabBar.items?.first?.title = "Random"
            tabBarController.tabBar.items?.first?.image = UIImage(systemName: "photo")

            tabBarController.tabBar.items?.last?.title = "Departments"
            tabBarController.tabBar.items?.last?.image = UIImage(systemName: "photo.stack")

            tabBarController.modalPresentationStyle = .fullScreen
            navigationController.present(tabBarController, animated: true)
        }
    }
}

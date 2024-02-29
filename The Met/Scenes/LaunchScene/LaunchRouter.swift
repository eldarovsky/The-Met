//
//  LaunchRouter.swift
//  The Met
//
//  Created by Eldar Abdullin on 01.01.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import UIKit

// MARK: - LaunchRouterProtocol
protocol LaunchRouterProtocol: BaseRouting {}

// MARK: - LaunchRouter
final class LaunchRouter {
    
    // MARK: - Route cases
    enum Target {
        case tabBar(imageIDs: [Int])
    }
    
    // MARK: - Private properties
    private let navigationController: UINavigationController
    
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - LaunchRouter protocol extension
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

//
//  DepartmentsRouter.swift
//  The Met
//
//  Created by Eldar Abdullin on 18.02.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import UIKit

// MARK: - DepartmentsRouterProtocol
protocol DepartmentsRouterProtocol: BaseRouting {}

// MARK: - DepartmentsRouter
final class DepartmentsRouter {
    
    // MARK: - Route cases
    enum Target {
        case randomArt(imageIDs: [Int])
    }
    
    // MARK: - Private properties
    private let navigationController: UINavigationController
    
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - DepartmentsRouter protocol extension
extension DepartmentsRouter: DepartmentsRouterProtocol {
    func routeTo(target: Any) {
        guard let target = target as? DepartmentsRouter.Target else { return }
        
        switch target {
        case .randomArt (let imageIDs):
            let randomArtVC = RandomArtViewController()
            let randomArtAssembler = RandomArtAssembler(navigationController: navigationController, imageIDs: imageIDs)
            randomArtAssembler.configure(viewController: randomArtVC)
            
            randomArtVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
            navigationController.pushViewController(randomArtVC, animated: true)
        }
    }
}

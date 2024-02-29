//
//  RandomArtRouter.swift
//  The Met
//
//  Created by Eldar Abdullin on 01.01.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import UIKit

// MARK: - RandomArtRouterProtocol
protocol RandomArtRouterProtocol: BaseRouting {}

// MARK: - RandomArtRouter
final class RandomArtRouter {
    
    // MARK: - Route cases
    enum Target {
        case zoomArt(fromData: Data)
    }
    
    // MARK: - Private properties
    private let navigationController: UINavigationController
    
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - RandomArtRouter protocol extension
extension RandomArtRouter: RandomArtRouterProtocol {
    func routeTo(target: Any) {
        guard let target = target as? RandomArtRouter.Target else { return }
        
        switch target {
        case .zoomArt (let imageData):
            let zoomVC = ZoomSceneViewController(imageData: imageData)
            navigationController.present(zoomVC, animated: true)
        }
    }
}

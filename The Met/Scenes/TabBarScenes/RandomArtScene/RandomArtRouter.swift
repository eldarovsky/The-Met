//
//  RandomArtRouter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

protocol RandomArtRouterProtocol: BaseRouting {}

final class RandomArtRouter {
    enum Target {
        case zoomArt(fromData: Data)
    }

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

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

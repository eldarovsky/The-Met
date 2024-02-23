//
//  DepartmentsRouter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 18.02.2024.
//

import UIKit

protocol DepartmentsRouterProtocol: BaseRouting {}

final class DepartmentsRouter {
    enum Target {
        case randomArt(imageIDs: [Int])
    }

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension DepartmentsRouter: DepartmentsRouterProtocol {
    func routeTo(target: Any) {
        guard let target = target as? DepartmentsRouter.Target else { return }

        switch target {
        case .randomArt (let imageIDs):
            let randomArtVC = RandomArtViewController()
            let randomArtNavigationController = UINavigationController(rootViewController: randomArtVC)
            let randomArtAssembler = RandomArtAssembler(navigationController: randomArtNavigationController, imageIDs: imageIDs)
            randomArtAssembler.configure(viewController: randomArtVC)

            navigationController.pushViewController(randomArtVC, animated: true)
        }
    }
}

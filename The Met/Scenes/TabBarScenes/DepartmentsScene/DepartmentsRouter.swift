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
            let randomArtAssembler = RandomArtAssembler(navigationController: navigationController, imageIDs: imageIDs)
            randomArtAssembler.configure(viewController: randomArtVC)

            randomArtVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
            navigationController.pushViewController(randomArtVC, animated: true)
        }
    }
}

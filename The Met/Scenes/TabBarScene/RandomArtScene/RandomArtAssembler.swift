//
//  RandomArtAssembler.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

final class RandomArtAssembler {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension RandomArtAssembler: BaseAssembly {
    func configure(viewController: UIViewController) {
        let router = RandomArtRouter(navigationController: navigationController)
        let presenter = RandomArtPresenter(router: router)
        guard let randomArtVC = viewController as? RandomArtViewController else { return }

        presenter.view = randomArtVC
        randomArtVC.presenter = presenter
    }
}

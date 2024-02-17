//
//  LaunchAssembler.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

final class LaunchAssembler {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension LaunchAssembler: BaseAssembly {
    func configure(viewController: UIViewController) {
        let router = LaunchRouter(navigationController: navigationController)
        let presenter = LaunchPresenter(router: router)
        guard let launchVC = viewController as? LaunchViewController else { return }

        presenter.view = launchVC
        launchVC.presenter = presenter
    }
}

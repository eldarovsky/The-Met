//
//  DepartmentsAssembler.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 18.02.2024.
//

import UIKit

final class DepartmentsAssembler {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension DepartmentsAssembler: BaseAssembler {
    func configure(viewController: UIViewController) {
        let router = DepartmentsRouter(navigationController: navigationController)
        let presenter = DepartmentsPresenter(router: router)
        guard let departmentsVC = viewController as? DepartmentsViewController else { return }

        presenter.view = departmentsVC
        departmentsVC.presenter = presenter
    }
}

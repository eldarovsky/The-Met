//
//  DepartmentsRouter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 18.02.2024.
//

import UIKit

protocol DepartmentsRouterProtocol {}

final class DepartmentsRouter {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension DepartmentsRouter: DepartmentsRouterProtocol {}

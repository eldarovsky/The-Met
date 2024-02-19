//
//  DepartmentsPresenter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 18.02.2024.
//

import Foundation

protocol DepartmentsPresenterProtocol {}

final class DepartmentsPresenter {
    weak var view: DepartmentsViewControllerProtocol?
    let router: DepartmentsRouterProtocol

    init(router: DepartmentsRouterProtocol) {
        self.router = router
    }
}

extension DepartmentsPresenter: DepartmentsPresenterProtocol {}

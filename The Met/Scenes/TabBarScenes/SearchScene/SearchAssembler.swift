//
//  SearchAssembler.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 11.03.2024.
//

import UIKit

// MARK: - SearchAssembler
final class SearchAssembler {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - SearchAssembler extension
extension SearchAssembler: BaseAssembler {
    func configure(viewController: UIViewController) {
        let router = SearchRouter(navigationController: navigationController)
        let presenter = SearchPresenter(router: router)
        guard let searchVC = viewController as? SearchViewController else { return }

        presenter.view = searchVC
        searchVC.presenter = presenter
    }
}

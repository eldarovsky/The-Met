//
//  RandomArtAssembler.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

final class RandomArtAssembler {
    private let navigationController: UINavigationController
    private let imageIDs: [Int]

    init(navigationController: UINavigationController, imageIDs: [Int]) {
        self.navigationController = navigationController
        self.imageIDs = imageIDs
    }
}

extension RandomArtAssembler: BaseAssembler {
    func configure(viewController: UIViewController) {
        let router = RandomArtRouter(navigationController: navigationController)
        let presenter = RandomArtPresenter(router: router, imageIDs: imageIDs)
        guard let randomArtVC = viewController as? RandomArtViewController else { return }

        presenter.view = randomArtVC
        randomArtVC.presenter = presenter
    }
}

//
//  ZoomSceneAssembler.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 25.02.2024.
//

import UIKit

final class ZoomSceneAssembler: BaseAssembler {
    private let image: Data

    init(image: Data) {
        self.image = image
    }

    func configure(viewController: UIViewController) {
        guard let zoomVC = viewController as? ZoomSceneViewController else { return }
        let presenter = ZoomScenePresenter(image: image)

        zoomVC.presenter = presenter
        presenter.view = zoomVC
    }
}

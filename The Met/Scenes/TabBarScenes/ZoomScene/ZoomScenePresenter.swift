//
//  ZoomScenePresenter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 25.02.2024.
//

import Foundation

protocol ZoomScenePresenterProtocol {
    func getImage() -> Data
}

final class ZoomScenePresenter {
    weak var view: ZoomSceneViewControllerProtocol?
    var image: Data

    init(image: Data) {
        self.image = image
    }
}

extension ZoomScenePresenter: ZoomScenePresenterProtocol {
    func getImage() -> Data {
        return image
    }
}

//
//  ZoomScenePresenter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 27.02.2024.
//

import Foundation

protocol ZoomScenePresenterProtocol {
    func closeScene()
}

final class ZoomScenePresenter {
    weak var view: ZoomSceneViewControllerProtocol?

    private let imageData: Data

    init(imageData: Data) {
        self.imageData = imageData
    }
}

extension ZoomScenePresenter: ZoomScenePresenterProtocol {
    func closeScene() {
        
    }
}

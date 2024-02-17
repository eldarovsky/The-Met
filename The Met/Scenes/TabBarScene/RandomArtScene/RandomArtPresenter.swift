//
//  RandomArtPresenter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import Foundation

protocol IRandomArtPresenter {
    
}

final class RandomArtPresenter {
    weak var view: IRandomArtViewController?
    let router: IRandomArtRouter

    init(router: IRandomArtRouter) {
        self.router = router
    }
}

extension RandomArtPresenter: IRandomArtPresenter {
    
}

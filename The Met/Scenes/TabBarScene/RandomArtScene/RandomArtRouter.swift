//
//  RandomArtRouter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

protocol IRandomArtRouter {

}

final class RandomArtRouter {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension RandomArtRouter: IRandomArtRouter {
    
}

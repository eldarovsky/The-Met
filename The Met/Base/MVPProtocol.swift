//
//  MVPProtocol.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

protocol BaseAssembler {
    func configure(viewController: UIViewController)
}

protocol BaseRouting {
    func routeTo(target: Any)
    init(navigationController: UINavigationController)
}

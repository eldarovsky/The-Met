//
//  MVPProtocol.swift
//  The Met
//
//  Created by Eldar Abdullin on 01.01.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import UIKit

// MARK: - Base Assembler Protocol
protocol BaseAssembler {
    func configure(viewController: UIViewController)
}

// MARK: - Base Routing Protocol
protocol BaseRouting {
    func routeTo(target: Any)
    init(navigationController: UINavigationController)
}

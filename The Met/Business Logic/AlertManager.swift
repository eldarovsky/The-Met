//
//  AlertManager.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 29.02.2024.
//

import UIKit

final class AlertManager {
    static let shared = AlertManager()

    private init() {}

    func alertAction(
        fromVC viewController: UIViewController? = nil,
        withTitle title: String? = "You are offline",
        andMessage message: String? = "Please check your network",
        buttonTitle: String? = "OK",
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion?()
        }
        alert.addAction(action)

        guard let viewController = viewController else { return }
        viewController.present(alert, animated: true)
    }
}

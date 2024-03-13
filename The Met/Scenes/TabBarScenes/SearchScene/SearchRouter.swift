//
//  SearchRouter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 11.03.2024.
//

//import UIKit
//
//// MARK: - SearchRouterProtocol
//protocol SearchRouterProtocol: BaseRouting {}
//
//// MARK: - SearchRouter
//final class SearchRouter {
//
//    // MARK: - Route cases
//    enum Target {
//        case zoomArt(fromData: Data)
//    }
//
//    // MARK: - Private properties
//    private let navigationController: UINavigationController
//
//    // MARK: - Initializer
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//}
//
//// MARK: - RandomArtRouter protocol extension
//extension SearchRouter: SearchRouterProtocol {
//    func routeTo(target: Any) {
//        guard let target = target as? SearchRouter.Target else { return }
//
//        switch target {
//        case .zoomArt (let imageData):
//            let zoomVC = ZoomSceneViewController(imageData: imageData)
//            navigationController.present(zoomVC, animated: true)
//        }
//    }
//}




import UIKit

// MARK: - SearchRouterProtocol
protocol SearchRouterProtocol: BaseRouting {}

// MARK: - SearchRouter
final class SearchRouter {

    // MARK: - Route cases
    enum Target {
        case zoomArt(fromData: Data)
    }

    // MARK: - Private properties
    private let navigationController: UINavigationController

    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - RandomArtRouter protocol extension
extension SearchRouter: SearchRouterProtocol {
    func routeTo(target: Any) {
        guard let target = target as? SearchRouter.Target else { return }

        switch target {
        case .zoomArt (let imageData):
            let zoomVC = ZoomSceneViewController(imageData: imageData)
            navigationController.present(zoomVC, animated: true)
        }
    }
}

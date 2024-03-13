//
//  SearchPresenter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 11.03.2024.
//

//import Foundation
//
//// MARK: - SearchPresenterProtocol
//protocol SearchPresenterProtocol {
//
//}
//
//// MARK: - SearchPresenter
//final class SearchPresenter {
//
//    // MARK: - Public properties
//    weak var view: SearchViewControllerProtocol?
//
//    // MARK: - Private properties
//    private let router: SearchRouterProtocol
//
//
//
//    // MARK: - Initializer
//    init(router: SearchRouterProtocol) {
//        self.router = router
//    }
//}
//
//// MARK: - SearchPresenter protocol extension
//extension SearchPresenter: SearchPresenterProtocol {
//
//}






import Foundation

// MARK: - SearchPresenterProtocol
protocol SearchPresenterProtocol {
    func getImageIDs(fromSearch text: String, completion: @escaping ([Int]) -> Void)
}

// MARK: - SearchPresenter
final class SearchPresenter {

    // MARK: - Public properties
    weak var view: SearchViewControllerProtocol?

    // MARK: - Private properties
    private let router: SearchRouterProtocol
    private let networkManager = NetworkManager.shared



    // MARK: - Initializer
    init(router: SearchRouterProtocol) {
        self.router = router
    }
}

// MARK: - SearchPresenter protocol extension
extension SearchPresenter: SearchPresenterProtocol {
    func getImageIDs(fromSearch text: String, completion: @escaping ([Int]) -> Void) {
        guard !text.isEmpty else { return }

        let searchURL = Link.searchURL + "\(text.lowercased())"

        //        isParsing = true

        networkManager.fetchObjects(Objects.self, from: searchURL) { [weak self] result in
            //            defer {
            //                self?.isParsing = false
            //            }

            switch result {
            case .success(let objectIDs):
//                self?.imageIDs = objectIDs.objectIDs.sorted()

                let sortedIDs = objectIDs.objectIDs.sorted()
                completion(sortedIDs)

                DispatchQueue.main.async {
                    self?.view?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//
//  RandomArtPresenter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

// MARK: - RandomArtSceneModel
struct RandomArtModel {
    let imageData: Data
    let description: String
}

protocol RandomArtPresenterProtocol {
    func fetchObject()
    func getArt()
}

final class RandomArtPresenter {
    weak var view: RandomArtViewControllerProtocol?
    let router: RandomArtRouterProtocol
    private let networkManager = NetworkManager.shared
    var imageIDs: [Int]

    init(router: RandomArtRouterProtocol, imageIDs: [Int]) {
        self.router = router
        self.imageIDs = imageIDs
    }
}

extension RandomArtPresenter: RandomArtPresenterProtocol {
    private func getImageURL() -> String {
        let objectsURL = Link.baseURL
        let imageURL = String(imageIDs.randomElement() ?? 168777)
        return "\(objectsURL)/\(imageURL)"
    }

    // MARK: - Private methods
//    @objc
//    private func artTapped(_ sender: UITapGestureRecognizer) {
//        guard let tappedImage = sender.view as? UIImageView else { return }
//        performSegue(withIdentifier: "fullsizeArt", sender: tappedImage.image)
//    }
    
    func fetchObject() {

        let url = getImageURL()

        networkManager.fetchObjects(Object.self, from: url) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.startAnimating()
            }

            switch result {
            case .success(let data):
                let access = data.isPublicDomain

                if access {
                    self?.networkManager.fetchImage(from: data.primaryImageSmall) { [weak self] result in
                        switch result {
                        case .success(let imageData):
                            let randomArtModel = RandomArtModel(imageData: imageData, description: data.description)
                            self?.view?.render(randomArtModel: randomArtModel)

                            DispatchQueue.main.async {
                                self?.view?.stopAnimating()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)

                            DispatchQueue.main.async {
                                guard let self = self else { return }
                                self.networkManager.alertAction() {
                                    self.view?.stopAnimating()
                                }
                            }
                        }
                    }
                } else {
                    self?.view?.showFetchingStatus(text:
                          """
                            NOT IN PUBLIC DOMAIN:
                            \(data.artistDisplayName) - \(data.title)
                            """
                    )

                    self?.fetchObject()
                }
            case .failure(let error):
                print(error.localizedDescription)

                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.networkManager.alertAction() {
                        self.view?.stopAnimating()
                    }
                }
            }
        }
    }

    func getArt() {
        fetchObject()
    }
}

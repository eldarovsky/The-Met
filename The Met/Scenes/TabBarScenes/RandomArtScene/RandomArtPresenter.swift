//
//  RandomArtPresenter.swift
//  The Met
//
//  Created by Eldar Abdullin on 01.01.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import Foundation

// MARK: - RandomArtSceneModel
struct RandomArtModel {
    let imageData: Data
    let description: String
}

protocol RandomArtPresenterProtocol {
    func fetchObject()
    func zoomArt()
}

final class RandomArtPresenter {

    weak var view: RandomArtViewControllerProtocol?
    private let router: RandomArtRouterProtocol
    
    private let networkManager = NetworkManager.shared
    private let alertManager = AlertManager.shared
    private var imageIDs: [Int]
    private var currentImage: Data?

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
                            
                            DispatchQueue.main.async {
                                self?.view?.render(randomArtModel: randomArtModel)
                                self?.currentImage = imageData
                                self?.view?.stopAnimating()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            
                            DispatchQueue.main.async {
                                self?.view?.stopAnimating()
                                
                                guard let self = self else { return }
                                guard let viewController = self.view as? RandomArtViewController else { return }
                                self.alertManager.alertAction(fromVC: viewController, buttonTitle: "RETRY") {
                                    self.fetchObject()
                                }
                            }
                        }
                    }
                } else {
                    self?.view?.showDescription(text:
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
                    self?.view?.stopAnimating()
                    
                    guard let self = self else { return }
                    guard let viewController = self.view as? RandomArtViewController else { return }
                    self.alertManager.alertAction(fromVC: viewController, buttonTitle: "RETRY") {
                        self.fetchObject()
                    }
                }
            }
        }
    }
    
    func zoomArt() {
        guard let currentImage = currentImage else { return }
        router.routeTo(target: RandomArtRouter.Target.zoomArt(fromData: currentImage))
    }
}

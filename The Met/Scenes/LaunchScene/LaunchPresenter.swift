//
//  LaunchPresenter.swift
//  The Met
//
//  Created by Eldar Abdullin on 01.01.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import Foundation

// MARK: - LaunchPresenterProtocol
protocol LaunchPresenterProtocol {
    func fetchObjects()
    func startProgressViewAnimation()
    func resetProgress()
    func stopProgressViewAnimation()
}

// MARK: - LaunchPresenter
final class LaunchPresenter {
    
    // MARK: - Public properties
    weak var view: LaunchViewControllerProtocol?
    
    // MARK: - Private properties
    private let router: LaunchRouterProtocol
    
    private let networkManager = NetworkManager.shared
    private let alertManager = AlertManager.shared
    private let progress = Progress(totalUnitCount: 5)
    private var progressTimer: Timer?
    
    // MARK: - Initializer
    init(router: LaunchRouterProtocol) {
        self.router = router
    }
}

// MARK: - LaunchPresenter protocol extension
extension LaunchPresenter: LaunchPresenterProtocol {
    func fetchObjects() {
        networkManager.fetchObjects(Objects.self, from: Link.baseURL) { [weak self] result in
            switch result {
            case .success(let objects):
                DispatchQueue.main.async {
                    self?.view?.updateProgressView(progress: 1)
                    self?.router.routeTo(target: LaunchRouter.Target.tabBar(imageIDs: objects.objectIDs))
                    self?.stopProgressViewAnimation()
                }
            case .failure(let error):
                print(error.localizedDescription)
                
                DispatchQueue.main.async {
                    self?.resetProgress()
                    self?.stopProgressViewAnimation()
                    
                    guard let self = self else { return }
                    guard let viewController = self.view as? LaunchViewController else { return }
                    self.alertManager.alertAction(fromVC: viewController, buttonTitle: "RETRY") {
                        self.startProgressViewAnimation()
                        self.fetchObjects()
                    }
                }
            }
        }
    }
    
    func startProgressViewAnimation() {
        let duration: TimeInterval = 1.0
        
        progressTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                guard !self.progress.isFinished else {
                    self.progress.completedUnitCount = 0
                    self.view?.updateProgressView(progress: 0)
                    return
                }
                
                self.progress.completedUnitCount += 1
                
                let progressFloat = Float(self.progress.fractionCompleted)
                
                self.view?.animateProgressView(withDuration: duration, delay: 0, progressFloat: progressFloat)
            }
        }
        
        progressTimer?.fire()
    }
    
    func resetProgress() {
        progress.completedUnitCount = 0
        self.view?.updateProgressView(progress: 0)
    }
    
    func stopProgressViewAnimation() {
        progressTimer?.invalidate()
        progressTimer = nil
    }
}

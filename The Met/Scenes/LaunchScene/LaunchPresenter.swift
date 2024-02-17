//
//  LaunchPresenter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import Foundation

protocol ILaunchPresenter {
    func fetchObjects()
    func startProgressViewAnimation()
    func stopProgressViewAnimation()
    func resetProgress()
}

final class LaunchPresenter {
    
    weak var view: ILaunchViewController?
    let router: ILaunchRouter
    
    init(router: ILaunchRouter) {
        self.router = router
    }
    
    // MARK: - Private properties
    private let networkManager = NetworkManager.shared
    private var imageIDs: [Int]?
    private var progressTimer: Timer?
    private let progress = Progress(totalUnitCount: 5)
}

extension LaunchPresenter: ILaunchPresenter {
    
    // MARK: - Start Progress Animation
    func startProgressViewAnimation() {
        let duration: TimeInterval = 1.0
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
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
    }
    
    // MARK: - Stop Progress Animation
    func stopProgressViewAnimation() {
        progressTimer?.invalidate()
        progressTimer = nil
    }
    
    // MARK: - Reset Progress Animation
    func resetProgress() {
        progress.completedUnitCount = 0
        self.view?.updateProgressView(progress: 0)
    }
    
    // MARK: - Fetching method
    func fetchObjects() {
        networkManager.fetchObjects(Objects.self, from: Link.baseURL) { [weak self] result in
            switch result {
            case .success(let objects):
                DispatchQueue.main.async {
                    self?.view?.updateProgressView(progress: 1)
                    self?.imageIDs = objects.objectIDs
                    self?.router.routeTo(target: LaunchRouter.Target.tabBar)
                    self?.stopProgressViewAnimation()
                }

            case .failure(let error):
                print(error.localizedDescription)
                
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    
                    self.networkManager.alertAction(fromVC: LaunchViewController(), buttonTitle: "RETRY") {
                        self.fetchObjects()
                    }
                    
                    self.resetProgress()
                }
            }
        }
    }
}

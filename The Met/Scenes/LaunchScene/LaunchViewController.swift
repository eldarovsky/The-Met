//
//  LaunchViewController.swift
//  The Met
//
//  Created by Eldar Abdullin on 01.01.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import UIKit

// MARK: - LaunchViewControllerProtocol
protocol LaunchViewControllerProtocol: AnyObject {
    func updateProgressView(progress: Float)
    func animateProgressView(withDuration: TimeInterval, delay: TimeInterval, progressFloat: Float)
}

// MARK: - LaunchViewController
final class LaunchViewController: UIViewController {
    
    // MARK: - UI elements
    private let logo = UIImageView(frame: CGRect(x: 0, y: 0, width: 151, height: 150))
    private let progressView = UIProgressView()
    
    // MARK: - Public properties
    var presenter: LaunchPresenterProtocol?
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.presenter?.fetchObjects()
        self.presenter?.startProgressViewAnimation()
    }
}

// MARK: - LaunchViewController extension
private extension LaunchViewController {
    func setupView() {
        setupUI()
        addViews()
        setupLayout()
    }
}

private extension LaunchViewController {
    func setupUI() {
        title = "The Metropolitan Museum of Art"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = .customRed
        
        guard let image = UIImage(named: "logo") else { return }
        logo.image = image
        logo.contentMode = .scaleAspectFit
        
        progressView.setProgress(0, animated: false)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 4
        progressView.progressTintColor = .white
        progressView.trackTintColor = .customGray
    }
    
    func addViews() {
        [logo, progressView].forEach { subview in
            view.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 42),
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -42),
            progressView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -42),
            progressView.heightAnchor.constraint(equalToConstant: 8)
        ])
    }
}

// MARK: - LaunchViewControllerProtocol extension
extension LaunchViewController: LaunchViewControllerProtocol {
    func updateProgressView(progress: Float) {
        progressView.setProgress(progress, animated: true)
    }
    
    func animateProgressView(withDuration: TimeInterval, delay: TimeInterval, progressFloat: Float) {
        UIView.animate(
            withDuration: withDuration,
            delay: delay,
            options: .curveLinear) {
                self.progressView.setProgress(progressFloat, animated: true)
            }
    }
}

//
//  LaunchViewController.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

protocol LaunchViewControllerProtocol: AnyObject {
    func updateProgressView(progress: Float)
    func animateProgressView(withDuration: TimeInterval, delay: TimeInterval, progressFloat: Float)
//    func performTransition(to viewController: UIViewController)
}

// MARK: - LaunchViewController
final class LaunchViewController: UIViewController {

    var presenter: LaunchPresenterProtocol?

    // MARK: - UI elements
    private let logo = UIImageView(frame: CGRect(x: 0, y: 0, width: 151, height: 150))
    private let progressView = UIProgressView()

    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.presenter?.fetchObjects()
        self.presenter?.startProgressViewAnimation()
    }
}

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
        view.backgroundColor = .launchScreen

        guard let image = UIImage(named: "logo") else { return }
        logo.image = image
        logo.contentMode = .scaleAspectFit

        progressView.setProgress(0, animated: false)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 4
        progressView.progressTintColor = .white
        progressView.trackTintColor = .customGrey
    }

    func addViews() {
        [logo, progressView].forEach { subview in
            view.addSubview(subview)
        }
    }

    func setupLayout() {
        [logo, progressView].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
        }

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

//    func performTransition(to viewController: UIViewController) {
//        self.navigationController?.pushViewController(viewController, animated: true)
//    }
}

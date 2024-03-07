//
//  RandomArtViewController.swift
//  The Met
//
//  Created by Eldar Abdullin on 01.01.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import UIKit

// MARK: - RandomArtViewControllerProtocol
protocol RandomArtViewControllerProtocol: AnyObject {
    func render(randomArtModel: RandomArtModel)
    func showDescription(text: String)
    func startAnimating()
    func stopAnimating()
}

// MARK: - RandomArtViewController
final class RandomArtViewController: UIViewController {
    
    // MARK: - UI elements
    private let canvas = UIImageView()
    private let art = UIImageView()
    private let activityIndicator = UIActivityIndicatorView()
    private let placard = UIImageView()
    private let descriptionLabel = UILabel()
    private let nextButton = CustomButton(
        title: "Next",
        titleNormalColor: .white,
        titleHighlightColor: .customGrayLight,
        font: .systemFont(ofSize: 21),
        backgroundColor: .clear,
        width: 150,
        height: 40
    )
    
    // MARK: - Public properties
    var presenter: RandomArtPresenterProtocol?
    
    // MARK: - Private properties
    private let hapticFeedbackManager = HapticFeedbackManager.shared
    private let tapGesture = UITapGestureRecognizer()
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addActions()
        presenter?.fetchObject()
    }
    
    // MARK: - Private methods
    @objc private func getArt() {
        hapticFeedbackManager.enableFeedback()
        presenter?.fetchObject()
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func imageTapped() {
        presenter?.zoomArt()
    }
}

// MARK: - RandomArtViewController extension
private extension RandomArtViewController {
    func setupView() {
        setupUI()
        addViews()
        setupLayout()
    }
    
    func addActions() {
        tapGesture.addTarget(self, action: #selector(imageTapped))
        art.addGestureRecognizer(tapGesture)
        
        nextButton.addTarget(self, action: #selector(getArt), for: .touchUpInside)
    }
}

private extension RandomArtViewController {
    func setupUI() {
        setupScreen()
        setupCanvas()
        setupArt()
        setupActivityIndicator()
        setupPlacard()
        setupDescription()
        setupButton()
    }
}

private extension RandomArtViewController {
    func setupScreen() {
        view.backgroundColor = .customGreenLight
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupCanvas() {
        canvas.layer.masksToBounds = false
        canvas.layer.shadowColor = .shadow.cgColor
        canvas.layer.shadowRadius = 4
        canvas.layer.shadowOpacity = 1
        canvas.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        guard let image = UIImage(named: "canvas") else { return }
        canvas.image = image
        canvas.contentMode = .scaleToFill
    }
    
    func setupArt() {
        art.layer.masksToBounds = false
        art.layer.shadowRadius = 0.5
        art.layer.shadowOpacity = 0.25
        art.layer.shadowOffset = CGSize(width: -1, height: -1)
        art.contentMode = .scaleAspectFit
        art.isUserInteractionEnabled = true
    }
    
    func setupActivityIndicator() {
        activityIndicator.color = .customGray
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
    }
    
    func setupPlacard() {
        placard.backgroundColor = .white
        placard.layer.masksToBounds = false
        placard.layer.cornerRadius = 4
        placard.layer.shadowRadius = 4
        placard.layer.shadowOpacity = 0.25
        placard.layer.shadowOffset = CGSize(width: 2, height: 2)
        placard.contentMode = .scaleAspectFill
    }
    
    func setupDescription() {
        descriptionLabel.text = ""
        descriptionLabel.font = UIFont.systemFont(ofSize: 17)
        descriptionLabel.minimumScaleFactor = 0.5
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .customGray
        descriptionLabel.textAlignment = .left
        descriptionLabel.adjustsFontSizeToFitWidth = true
    }
    
    func addViews() {
        [canvas, art, activityIndicator, placard, descriptionLabel, nextButton].forEach { subview in
            view.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            canvas.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            canvas.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            canvas.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            canvas.widthAnchor.constraint(equalTo: canvas.heightAnchor, multiplier: 191/232),
            
            art.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 48),
            art.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 48),
            art.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -48),
            art.bottomAnchor.constraint(equalTo: canvas.bottomAnchor, constant: -48),
            
            activityIndicator.centerXAnchor.constraint(equalTo: art.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: art.centerYAnchor),
            
            placard.topAnchor.constraint(equalTo: canvas.bottomAnchor, constant: 16),
            placard.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            placard.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            placard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -72),
            
            descriptionLabel.topAnchor.constraint(equalTo: placard.topAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: placard.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: placard.trailingAnchor, constant: -8),
            descriptionLabel.heightAnchor.constraint(lessThanOrEqualTo: placard.heightAnchor, constant: -16),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: nextButton.heightAnchor, multiplier: 15/4, constant: 0),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    func setupButton() {
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        nextButton.setTitleColor(UIColor.customGray, for: .normal)
    }
}

// MARK: - RandomArtViewController protocol extension
extension RandomArtViewController: RandomArtViewControllerProtocol {
    func render(randomArtModel: RandomArtModel) {
        art.image = UIImage(data: randomArtModel.imageData)
        descriptionLabel.text = randomArtModel.description
    }
    
    func showDescription(text: String) {
        descriptionLabel.text = text
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}

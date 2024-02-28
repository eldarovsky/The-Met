//
//  RandomArtViewController.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

// MARK: - RandomArtViewControllerProtocol
protocol RandomArtViewControllerProtocol: AnyObject {
    func render(randomArtModel: RandomArtModel)
    func showDescription(text: String)
    func startAnimating()
    func stopAnimating()
}

final class RandomArtViewController: UIViewController {
    var presenter: RandomArtPresenterProtocol?

    let tapGesture = UITapGestureRecognizer()

    // MARK: - UI elements
    private let canvas = UIImageView()
    private let art = UIImageView()
    private let activityIndicator = UIActivityIndicatorView()
    private let placard = UIImageView()
    private let descriptionLabel = UILabel()
    private var nextButton = CustomButton(
        title: "Next",
        titleNormalColor: .white,
        titleHighlightColor: .customGrayLight,
        font: .systemFont(ofSize: 21),
        backgroundColor: .clear,
        width: 150,
        height: 40
    )

    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupView()
        addActions()

        presenter?.fetchObject()


        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.backButtonTitle = "Back"
    }

    @objc private func getArt() {
        presenter?.fetchObject()
    }

    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc func imageTapped() {
        presenter?.zoomArt()
    }
}

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

extension RandomArtViewController {
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

extension RandomArtViewController {
    func setupScreen() {
        view.backgroundColor = .background
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

        let normalColor = UIColor.customGray
        nextButton.setTitleColor(normalColor, for: .normal)
    }
}

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

//
//  RandomArtViewController.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

protocol IRandomArtViewController: AnyObject {

}

final class RandomArtViewController: UIViewController {
    var presenter: IRandomArtPresenter?

    // MARK: - UI elements
    private let canvas = UIImageView()
    private let art = UIImageView()
    private let activityIndicator = UIActivityIndicatorView()
    private let placard = UIImageView()
    private let descriptionLabel = UILabel()
    private var nextButton = CustomButton(
        title: "Next",
        titleNormalColor: .white,
        titleHighlightColor: ColorPalette.customGreyLight,
        font: .systemFont(ofSize: 21),
        backgroundColor: .clear,
        width: 150,
        height: 40
    )

    // MARK: - Private properties
    private let networkManager = NetworkManager.shared
    var imageIDs: [Int]? = []

    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
                setupView()
        //        fetchObject()
        art.backgroundColor = .green
    }

    // MARK: - Private methods
    @objc
    private func getArt() {
        fetchObject()
    }

    //    @objc
    //    private func artTapped(_ sender: UITapGestureRecognizer) {
    //        guard let tappedImage = sender.view as? UIImageView else { return }
    //
    //        performSegue(withIdentifier: "fullsizeArt", sender: tappedImage.image)
    //    }

    private func getImageURL() -> String {
        let objectsURL = Link.baseURL
        let imageURL = String(imageIDs?.randomElement() ?? 0)
        return "\(objectsURL)/\(imageURL)"
    }

    func fetchObject() {
        activityIndicator.startAnimating()

        let url = getImageURL()

        networkManager.fetchObjects(Object.self, from: url) { [weak self] result in
            switch result {
            case .success(let data):
                let access = data.isPublicDomain

                if access {
                    self?.networkManager.fetchImage(from: data.primaryImageSmall) { [weak self] result in
                        switch result {
                        case .success(let imageData):
                            DispatchQueue.main.async {
                                self?.art.image = UIImage(data: imageData)
                                self?.descriptionLabel.text = data.description
                                self?.activityIndicator.stopAnimating()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)

                            //                            DispatchQueue.main.async {
                            //                                guard let self = self else { return }
                            //                                self.networkManager.alertAction(fromVC: self) {
                            //                                    self.activityIndicator.stopAnimating()
                            //                                }
                            //                            }
                        }
                    }
                } else {
                    self?.descriptionLabel.text = """
                                NOT IN PUBLIC DOMAIN:
                                \(data.artistDisplayName) - \(data.title)
                                """

                    self?.fetchObject()
                }
            case .failure(let error):
                print(error.localizedDescription)

                //                DispatchQueue.main.async {
                //                    guard let self = self else { return }
                //                    self.networkManager.alertAction(fromVC: self) {
                //                        self.activityIndicator.stopAnimating()
                //                    }
                //                }
            }
        }
    }
}

private extension RandomArtViewController {
    func setupView() {
        setupUI()
        addViews()
        setupLayout()
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
    }
}

extension RandomArtViewController {
    func setupScreen() {
        view.backgroundColor = ColorPalette.background
        art.isUserInteractionEnabled = true
//        navigationItem.backBarButtonItem?.isEnabled = false
        navigationItem.backBarButtonItem?.isHidden = true



//        navigationItem.hidesBackButton = true

//        guard let navigationController = navigationController else { return }
////        navigationController.isNavigationBarHidden = true
//        navigationController.setNavigationBarHidden(true, animated: false)
    }

    func setupCanvas() {
        canvas.layer.masksToBounds = false
        canvas.layer.shadowColor = ColorPalette.shadow.cgColor
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
    }

    func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.contentMode = .scaleToFill
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
        descriptionLabel.textColor = ColorPalette.customGrey
        descriptionLabel.contentMode = .left
    }

    func addViews() {
        [canvas, art, activityIndicator, placard, descriptionLabel, nextButton].forEach { subview in
            view.addSubview(subview)
        }
    }

    func setupLayout() {
        [canvas, art, activityIndicator, placard, descriptionLabel, nextButton].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            canvas.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55),
            canvas.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            canvas.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            canvas.widthAnchor.constraint(equalTo: canvas.heightAnchor, multiplier: 191/232, constant: 0),

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
            descriptionLabel.bottomAnchor.constraint(equalTo: placard.bottomAnchor, constant: -8),

            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: nextButton.heightAnchor, multiplier: 15/4, constant: 0),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}



extension RandomArtViewController: IRandomArtViewController {

}

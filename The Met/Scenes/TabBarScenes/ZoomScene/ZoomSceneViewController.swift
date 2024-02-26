//
//  ZoomSceneViewController.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 25.02.2024.
//

import UIKit

protocol ZoomSceneViewControllerProtocol: AnyObject {}

final class ZoomSceneViewController: UIViewController, UIScrollViewDelegate {
    var presenter: ZoomScenePresenterProtocol?

    // MARK: - UI Elements
    private var closeButton = CustomButton(
        title: "",
        width: 30,
        height: 30
    )
    private var imageScrollView = UIScrollView()
    private var imageView = UIImageView()
    private var saveButton = CustomButton(
        title: "Save",
        width: 150,
        height: 40
    )

    // MARK: - Private properties
    private var image: UIImage?

    // MARK: - Overrided methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addActions()
        setImage()
    }

    // MARK: - Private methods
    @objc
    private func closeZoomScene() {
        dismiss(animated: true)
    }

    @objc
    private func saveImage() {
        guard let image = image else { return }

        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: image)

        imageView.sizeToFit()
        imageScrollView.contentSize = imageView.bounds.size
    }

    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        let scale = min(imageScrollView.maximumZoomScale, 2)
        let center = gesture.location(in: imageView)

        if imageScrollView.zoomScale != 1.0 {
            imageScrollView.setZoomScale(1.0, animated: true)
        } else {
            let zoomRect = CGRect(
                x: center.x - (imageScrollView.bounds.size.width / scale) / 2.0,
                y: center.y - (imageScrollView.bounds.size.height / scale) / 2.0,
                width: imageScrollView.bounds.size.width / scale,
                height: imageScrollView.bounds.size.height / scale
            )
            imageScrollView.zoom(to: zoomRect, animated: true)
        }
    }

    private func setupGestureRecognizer() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTapGesture)
    }

    private func setImage() {
        guard let imageData = presenter?.getImage() else { return }
        guard let image = UIImage(data: imageData) else { return }
        self.image = image
        imageView.image = image
    }
}

private extension ZoomSceneViewController {
    func setupView() {
        setupUI()
        addViews()
        setupLayout()
    }
}

private extension ZoomSceneViewController {
    func setupUI() {
        view.backgroundColor = .tertiarySystemGroupedBackground

        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)

        imageScrollView.delegate = self
        imageScrollView.showsVerticalScrollIndicator = false
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.decelerationRate = UIScrollView.DecelerationRate.fast
        imageScrollView.maximumZoomScale = 4.0

        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit

        saveButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
    }

    func addViews() {
        view.addSubview(closeButton)
        imageScrollView.addSubview(imageView)
        view.addSubview(imageScrollView)
        view.addSubview(saveButton)
    }

    func setupLayout() {
        [closeButton, imageScrollView, imageView, saveButton].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            imageScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 66),
            imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -121),

            imageView.topAnchor.constraint(equalTo: imageScrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageScrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageScrollView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor),
            imageView.centerXAnchor.constraint(equalTo: imageScrollView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageScrollView.centerYAnchor),

            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -66)
        ])
    }

    func addActions() {
        closeButton.addTarget(self, action: #selector(closeZoomScene), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
        setupGestureRecognizer()
    }
}

extension ZoomSceneViewController: ZoomSceneViewControllerProtocol {}

// MARK: - UIScrollViewDelegate
extension ZoomSceneViewController {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}

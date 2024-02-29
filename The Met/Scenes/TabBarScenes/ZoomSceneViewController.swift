//
//  ZoomSceneViewController.swift
//  The Met
//
//  Created by Eldar Abdullin on 25.02.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import UIKit

// MARK: - ZoomSceneViewController
final class ZoomSceneViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - UI Elements
    private let closeButton = CustomButton(title: "", width: 30, height: 30)
    private let saveButton = CustomButton(title: "Save", width: 150, height: 40)
    private let imageScrollView = UIScrollView()
    private let imageView = UIImageView()
    
    // MARK: - Private properties
    private let hapticFeedbackManager = HapticFeedbackManager.shared
    private var imageData: Data
    private var dataHashValue: Int = 0
    
    // MARK: - Overrided methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addActions()
    }
    
    // MARK: - Initializers
    init(imageData: Data) {
        self.imageData = imageData
        self.dataHashValue = UserDefaults.standard.integer(forKey: "dataHashValue")
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    @objc private func closeZoomScene() {
        dismiss(animated: true)
    }
    
    @objc private func saveImage() {
        hapticFeedbackManager.enableFeedback()
        
        if imageData.hashValue != dataHashValue {
            guard let image = UIImage(data: imageData) else { return }
            
            let imageSaver = ImageSaverManager()
            imageSaver.writeToPhotoAlbum(image: image)
            
            dataHashValue = imageData.hashValue
            UserDefaults.standard.set(dataHashValue, forKey: "dataHashValue")
        } else {
            let alert = UIAlertController(title: "This image has already been saved", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            
            present(alert, animated: true)
        }
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
    
    private func removeGestureRecognizers() {
        if let gestureRecognizers = imageView.gestureRecognizers {
            for gestureRecognizer in gestureRecognizers {
                imageView.removeGestureRecognizer(gestureRecognizer)
            }
        }
    }
    
    // MARK: - deinit GestureRecognizers
    deinit {
        removeGestureRecognizers()
    }
}

// MARK: - ZoomSceneViewController extension
private extension ZoomSceneViewController {
    func setupView() {
        setupUI()
        setImage()
        addViews()
        setupLayout()
    }
    
    func addActions() {
        closeButton.addTarget(self, action: #selector(closeZoomScene), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
        setupGestureRecognizer()
    }
}

// MARK: - ZoomSceneViewController extension
private extension ZoomSceneViewController {
    func setupUI() {
        view.backgroundColor = .tertiarySystemGroupedBackground
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        
        saveButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
        
        imageScrollView.delegate = self
        imageScrollView.showsVerticalScrollIndicator = false
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.decelerationRate = UIScrollView.DecelerationRate.fast
        imageScrollView.maximumZoomScale = 4.0
        
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
    }
    
    func setImage() {
        guard let image = UIImage(data: imageData) else { return }
        imageView.image = image
        imageView.sizeToFit()
        
        imageScrollView.contentSize = imageView.bounds.size
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
}

// MARK: - UIScrollViewDelegate
extension ZoomSceneViewController {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}

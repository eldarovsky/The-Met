//
//  SearchViewCell.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 12.03.2024.
//

import UIKit

// MARK: - SearchViewCellProtocol
protocol SearchViewCellProtocol {
//    func configure(from department: Department)
    func startAnimating()
    func stopAnimating()
    func showBlankCell()
}

// MARK: - SearchViewCell
final class SearchViewCell: UITableViewCell {

    // MARK: - UI elements
    private let searchImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        image.contentMode = .scaleAspectFill

        return image
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true

        return activityIndicator
    }()

    private let searchTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        return label
    }()

    private let searchSecondaryTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        return label
    }()

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        [searchImage, activityIndicator, searchTextLabel, searchSecondaryTextLabel].forEach { subview in
            contentView.addSubview(subview)
        }

        NSLayoutConstraint.activate([
            searchImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            searchImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchImage.widthAnchor.constraint(equalTo: searchImage.heightAnchor, multiplier: 1),
            searchImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            activityIndicator.centerXAnchor.constraint(equalTo: searchImage.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: searchImage.centerYAnchor),

            searchTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            searchTextLabel.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 16),
            searchTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchTextLabel.heightAnchor.constraint(equalToConstant: 21),

            searchSecondaryTextLabel.topAnchor.constraint(equalTo: searchTextLabel.bottomAnchor, constant: 8),
            searchSecondaryTextLabel.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 16),
            searchSecondaryTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchSecondaryTextLabel.heightAnchor.constraint(equalToConstant: 21)
        ])

        let backgroundView = UIView()
        backgroundView.backgroundColor = .customGreenLight
        self.backgroundView = backgroundView

        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .customGray.withAlphaComponent(0.5)
        self.selectedBackgroundView = selectedBackgroundView
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SearchViewCell protocol extension
extension SearchViewCell: SearchViewCellProtocol {
    func configure(from department: Department) {
        DispatchQueue.main.async {
            guard let image = UIImage(named: department.displayName) else { return }
            self.searchImage.image = image
            self.searchTextLabel.text = department.displayName
            self.searchSecondaryTextLabel.text = department.displayName
            self.activityIndicator.stopAnimating()
        }
    }

    func startAnimating() {
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
    }

    func showBlankCell() {
        searchImage.backgroundColor = .customGreen
        activityIndicator.startAnimating()
    }
}

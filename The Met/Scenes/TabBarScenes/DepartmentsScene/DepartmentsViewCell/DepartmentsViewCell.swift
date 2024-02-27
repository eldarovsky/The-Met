//
//  DepartmentsViewCell.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 20.02.2024.
//

import UIKit

protocol DepartmentsViewCellProtocol {
    func configure(from department: Department)
    func startAnimating()
    func stopAnimating()
    func showBlankCell()
}

class DepartmentsViewCell: UITableViewCell {
    private let departmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        return label
    }()

    private let departmentImage: UIImageView = {
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(departmentImage)
        contentView.addSubview(departmentLabel)
        contentView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            departmentImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            departmentImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            departmentImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            departmentImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            departmentLabel.topAnchor.constraint(equalTo: departmentImage.topAnchor),
            departmentLabel.leadingAnchor.constraint(equalTo: departmentImage.leadingAnchor),
            departmentLabel.trailingAnchor.constraint(equalTo: departmentImage.trailingAnchor),
            departmentLabel.heightAnchor.constraint(equalToConstant: 21),

            activityIndicator.centerXAnchor.constraint(equalTo: departmentImage.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: departmentImage.centerYAnchor)
        ])

        let backgroundView = UIView()
        backgroundView.backgroundColor = .background
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

extension DepartmentsViewCell: DepartmentsViewCellProtocol {
    func configure(from department: Department) {
        DispatchQueue.main.async {
            guard let image = UIImage(named: department.displayName) else { return }
            self.departmentImage.image = image
            self.departmentLabel.text = department.displayName
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
        departmentImage.backgroundColor = .backgroundTabBar
        activityIndicator.startAnimating()
    }
}

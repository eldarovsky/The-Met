//
//  DepartmentsViewController.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 03.01.2024.
//

import UIKit

protocol DepartmentsViewControllerProtocol: AnyObject {
    func render(departments: [Department])
}

final class DepartmentsViewController: UITableViewController {
    var presenter: DepartmentsPresenterProtocol?

    private var departments: [Department] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.getDepartmentsID()
    }
}

private extension DepartmentsViewController {
    func setupView() {
        setupUI()
        setupTableView()
    }
}

private extension DepartmentsViewController {
    func setupUI() {
        setupScreen()
        setupNavigationBar()
    }
}

private extension DepartmentsViewController {
    func setupScreen() {
        view.backgroundColor = .background
    }

    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.customGrey,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21)
        ]

        appearance.backgroundColor = .background

        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance

        title = "Departments"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .customGrey
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DepartmentsViewCell.self, forCellReuseIdentifier: "departmentCell")
        tableView.separatorStyle = .none
    }
}

extension DepartmentsViewController {
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !departments.isEmpty {
            return departments.count
        } else {
            return 19
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "departmentCell", for: indexPath)
        guard let cell = cell as? DepartmentsViewCell else { return UITableViewCell() }

        if !departments.isEmpty {
            let department = departments[indexPath.row]
            cell.configure(from: department)
        } else {
            cell.showBlankCell()
        }

        return cell
    }

    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

//        guard let parcingStatus = presenter?.getParcingStatus() else { return }
//        presenter?.toggleParcingStatus()

        guard let cell = tableView.cellForRow(at: indexPath) as? DepartmentsViewCell else { return }
        cell.startAnimating()

        let department = departments[indexPath.row]
        presenter?.getDepartmentsURL(fromDepartment: department)

        presenter?.getObjectsIDs(forCell: cell)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageHeight: CGFloat = 249
        let verticalInsets: CGFloat = 8 + 8

        return imageHeight + verticalInsets
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0

        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
        }
    }
}

extension DepartmentsViewController: DepartmentsViewControllerProtocol {
    func render(departments: [Department]) {
        self.departments = departments
        tableView.reloadData()
    }
}

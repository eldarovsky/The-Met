//
//  DepartmentsViewController.swift
//  The Met
//
//  Created by Eldar Abdullin on 03.01.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import UIKit

// MARK: - DepartmentsViewControllerProtocol
protocol DepartmentsViewControllerProtocol: AnyObject {
    func render(departments: [Department])
}

// MARK: - DepartmentsViewController
final class DepartmentsViewController: UITableViewController {
    
    // MARK: - Public properties
    var presenter: DepartmentsPresenterProtocol?
    
    // MARK: - Private properties
    private var departments: [Department] = []
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.getDepartmentsID()
    }
    
    // MARK: - Private methods
    @objc private func refreshData() {
        presenter?.resetParsingStatus()
        presenter?.getDepartmentsID()
        tableView.refreshControl?.endRefreshing()
    }
}

// MARK: - DepartmentsViewController extension
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
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DepartmentsViewCell.self, forCellReuseIdentifier: "departmentCell")
        tableView.separatorStyle = .none
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .customGray
        refreshControl.backgroundColor = .customGreen
        
        let attributedTitle = NSAttributedString(string: "Pull to Refresh", attributes: [.foregroundColor: UIColor.gray])
        refreshControl.attributedTitle = attributedTitle
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
}

private extension DepartmentsViewController {
    func setupScreen() {
        view.backgroundColor = .customGreenLight
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.customGray,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21)
        ]
        
        appearance.backgroundColor = .customGreenLight
        
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        
        title = "Departments"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .customGray
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
        
        guard let cell = tableView.cellForRow(at: indexPath) as? DepartmentsViewCell else { return }
        cell.startAnimating()
        
        guard !departments.isEmpty else { return }
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

// MARK: - DepartmentsViewController protocol extension
extension DepartmentsViewController: DepartmentsViewControllerProtocol {
    func render(departments: [Department]) {
        self.departments = departments
        tableView.reloadData()
    }
}

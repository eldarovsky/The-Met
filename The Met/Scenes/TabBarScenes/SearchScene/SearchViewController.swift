//
//  SearchViewController.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 11.03.2024.
//

import UIKit

// TODO: - SearchViewControllerProtocol
protocol SearchViewControllerProtocol: AnyObject {}

// MARK: - SearchViewController
final class SearchViewController: UITableViewController {

    // MARK: - Public properties
    var presenter: SearchPresenterProtocol?

    // MARK: - Private properties
    private let searchController = UISearchController()
    private let networkManager = NetworkManager.shared
    private var imageIDs: [Int] = []

    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private methods
    private func getImageURL(at index: Int) -> String {
        let objectsURL = Link.baseURL
        let imageURL = String(imageIDs[index])
        return "\(objectsURL)/\(imageURL)"
    }
}

// MARK: - SearchViewController extension
private extension SearchViewController {
    func setupView() {
        setupScreen()
        setupNavigationBar()
        setupSearchBar()
        setupTableView()
    }
}

private extension SearchViewController {
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

        title = "Search"

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .customGray
    }

    func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self

        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .customGray

        if #available(iOS 13.0, *) {
            let searchTextField = searchController.searchBar.searchTextField
            searchTextField.backgroundColor = .white
        } else {
            if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
                textField.backgroundColor = .white
            }
        }

        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.autocapitalizationType = .none
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        imageIDs.removeAll()
        tableView.reloadData()

        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else { return }
        let searchURL = Link.searchURL + "\(searchText.lowercased())"

        networkManager.fetchObjects(Objects.self, from: searchURL) { [weak self] result in
            switch result {
            case .success(let objectIDs):
                self?.imageIDs = objectIDs.objectIDs.sorted()

                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController {

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageIDs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear

        var content = cell.defaultContentConfiguration()
        content.imageProperties.reservedLayoutSize.width = 100
        content.imageProperties.reservedLayoutSize.height = 100
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        content.imageProperties.cornerRadius = 4

        let urlIndex = indexPath.row
        guard urlIndex < imageIDs.count else { return cell }
        let url = getImageURL(at: urlIndex)

        cell.imageView?.image = nil
        cell.textLabel?.text = nil
        cell.detailTextLabel?.text = nil

        networkManager.fetchObjects(Object.self, from: url) { [weak self] result in
            switch result {
            case .success(let data):
                let access = data.isPublicDomain

                DispatchQueue.main.async {
                    if access {
                        self?.networkManager.fetchImage(from: data.primaryImageSmall) { result in
                            switch result {
                            case .success(let imageData):
                                content.image = UIImage(data: imageData)
                                content.text = data.title
                                content.secondaryText = data.artistDisplayName
                                content.textProperties.numberOfLines = 2
                                cell.contentConfiguration = content
                                cell.setNeedsLayout()
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    } else {
                        content.image = UIImage(named: "public_domain_mark")?.withTintColor(.customGray)
                        content.text = "NOT IN PUBLIC DOMAIN"
                        content.secondaryText = "\(data.title) - \(data.artistDisplayName)"
                        cell.contentConfiguration = content
                        cell.setNeedsLayout()
                    }
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        return cell
    }

    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let imageURL = getImageURL(at: indexPath.row)

        networkManager.fetchObjects(Object.self, from: imageURL) { [weak self] result in
            switch result {
            case .success(let data):
                let access = data.isPublicDomain

                DispatchQueue.main.async {
                    if access {
                        self?.networkManager.fetchImage(from: data.primaryImageSmall) { result in
                            switch result {
                            case .success(let imageData):
                                let zoomVC = ZoomSceneViewController(imageData: imageData)
                                self?.navigationController?.present(zoomVC, animated: true)
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    }
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0

        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
        }
    }
}

// TODO: - SearchViewController protocol extension
extension SearchViewController: SearchViewControllerProtocol {}

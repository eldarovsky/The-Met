//
//  NetworkManager.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit
import Network

// MARK: - JSON links
enum Link {
    static let baseURL = "https://collectionapi.metmuseum.org/public/collection/v1/objects"
    static let departmentsURL = "https://collectionapi.metmuseum.org/public/collection/v1/departments"
    static let departmentURL = "https://collectionapi.metmuseum.org/public/collection/v1/objects?departmentIds="
}

// MARK: - Error types
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case noInternetConnection
}

// MARK: - Network Manager Protocol
protocol INetworkManager {
    func fetchObjects<T: Decodable>(_ type: T.Type, from url: String, completion: @escaping(Result<T, NetworkError>) -> Void)
    func fetchImage(from url: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

// MARK: - Network Manager
final class NetworkManager: INetworkManager {

    // MARK: - Static Property (singletone pattern)
    static let shared = NetworkManager()

    // MARK: - Private Properties
    private let pathMonitor = NWPathMonitor()
    private var isNetworkAvailable = true

    // MARK: - Private Initialiser (singletone pattern)
    private init() {
        startMonitoring()
    }

    // MARK: - Public Methods
    func fetchObjects<T: Decodable>(_ type: T.Type, from url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard isNetworkAvailable else {
            completion(.failure(.noInternetConnection))
            return
        }

        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let objectsData = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }

            let decoder = JSONDecoder()

            do {
                let typeData = try decoder.decode(T.self, from: objectsData)

                DispatchQueue.main.async {
                    completion(.success(typeData))
                }
            } catch {
                print(error.localizedDescription)
                completion(.failure(.decodingError))
            }
        }.resume()
    }

    func fetchImage(from url: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard isNetworkAvailable else {
            completion(.failure(.noInternetConnection))
            return
        }

        guard let imageURL = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            guard let imageData = data else {
                completion(.failure(.noData))
                return
            }

            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }.resume()
    }

    func alertAction(
        fromVC viewController: UIViewController? = nil,
        withTitle title: String = "You are offline",
        andMessage message: String = "Please check your network",
        buttonTitle: String = "OK",
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion?()
        }
        alert.addAction(action)

        guard let viewController = viewController else { return }
        viewController.present(alert, animated: true)
    }

    // MARK: - Private Methods
    private func startMonitoring() {
        pathMonitor.pathUpdateHandler = { [weak self] path in
            self?.isNetworkAvailable = path.status == .satisfied
        }

        pathMonitor.start(queue: DispatchQueue.main)
    }
}

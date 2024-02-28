//
//  NetworkManager.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

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
protocol NetworkManagerProtocol {
    func fetchObjects<T: Decodable>(_ type: T.Type, from url: String, timeoutInterval: TimeInterval, completion: @escaping(Result<T, NetworkError>) -> Void)
    func fetchImage(from url: String, timeoutInterval: TimeInterval, completion: @escaping (Result<Data, NetworkError>) -> Void)
    func alertAction(
        fromVC viewController: UIViewController?,
        withTitle title: String?,
        andMessage message: String?,
        buttonTitle: String?,
        completion: (() -> Void)?
    )
}

// MARK: - Network Manager
final class NetworkManager: NetworkManagerProtocol {

    // MARK: - Static Property (singletone pattern)
    static let shared = NetworkManager()

    // MARK: - Private Initialiser (singletone pattern)
    private init() {}

    // MARK: - Public Methods
    func fetchObjects<T: Decodable>(_ type: T.Type, from url: String, timeoutInterval: TimeInterval = 10, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = timeoutInterval

        URLSession.shared.dataTask(with: request) { data, _, error in
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

    func fetchImage(from url: String, timeoutInterval: TimeInterval = 10, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let imageURL = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: imageURL)
        request.timeoutInterval = timeoutInterval

        URLSession.shared.dataTask(with: request) { data, _, error in
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
        withTitle title: String? = "You are offline",
        andMessage message: String? = "Please check your network",
        buttonTitle: String? = "OK",
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
}

//
//  NetworkManager.swift
//  The Met
//
//  Created by Eldar Abdullin on 01.01.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import UIKit

// MARK: - JSON links
enum Link {
    static let baseURL = "https://collectionapi.metmuseum.org/public/collection/v1/objects"
    static let departmentsURL = "https://collectionapi.metmuseum.org/public/collection/v1/departments"
    static let departmentURL = "https://collectionapi.metmuseum.org/public/collection/v1/objects?departmentIds="
    static let searchURL = "https://collectionapi.metmuseum.org/public/collection/v1/search?hasImages=true&title=true&q="
}

// MARK: - Error types
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case noInternetConnection
}

// MARK: - Network Manager
final class NetworkManager {
    
    // MARK: - Static Property (singleton pattern)
    static let shared = NetworkManager()
    
    // MARK: - Private Initializer (singleton pattern)
    private init() {}
    
    // MARK: - Public Methods
    func fetchObjects<T: Decodable>(
        _ type: T.Type,
        from url: String,
        timeoutInterval: TimeInterval = 10,
        completion: @escaping(Result<T, NetworkError>) -> Void
    ) {
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
    
    func fetchImage(
        from url: String,
        timeoutInterval: TimeInterval = 10,
        completion: @escaping (Result<Data, NetworkError>) -> Void
    ) {
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
}

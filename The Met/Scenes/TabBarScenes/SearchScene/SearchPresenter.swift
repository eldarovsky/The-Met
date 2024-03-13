//
//  SearchPresenter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 11.03.2024.
//

import Foundation

// TODO: - SearchPresenterProtocol
protocol SearchPresenterProtocol {}

// TODO: - SearchPresenter
final class SearchPresenter {
    
    // MARK: - Public properties
    weak var view: SearchViewControllerProtocol?
    
    // MARK: - Private properties
    private let router: SearchRouterProtocol
    
    // MARK: - Initializer
    init(router: SearchRouterProtocol) {
        self.router = router
    }
}

// TODO: - SearchPresenter protocol extension
extension SearchPresenter: SearchPresenterProtocol {}

//
//  DepartmentsPresenter.swift
//  The Met
//
//  Created by Eldar Abdullin on 18.02.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import Foundation

protocol DepartmentsPresenterProtocol {
    func getDepartmentsID()
    func getDepartmentsURL(fromDepartment department: Department)
    func getObjectsIDs(forCell cell: DepartmentsViewCell)
    func getParsingStatus() -> Bool
    func resetParsingStatus()
}

final class DepartmentsPresenter {
    weak var view: DepartmentsViewControllerProtocol?
    private let router: DepartmentsRouterProtocol

    private let networkManager = NetworkManager.shared
    private var departments: [Department]?
    private var departmentURL = ""
    private var objectIDs: [Int]?
    private var isParsing = false

    init(router: DepartmentsRouterProtocol) {
        self.router = router
    }
}

extension DepartmentsPresenter: DepartmentsPresenterProtocol {
    func getDepartmentsID() {
        networkManager.fetchObjects(Departments.self, from: Link.departmentsURL) { [weak self] result in
            switch result {
            case .success(let departments):
                self?.departments = departments.departments
                self?.view?.render(departments: departments.departments)
            case .failure(let error):
                print(error.localizedDescription)

                self?.isParsing = false

                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.networkManager.alertAction()
                }
            }
        }
    }

    func getDepartmentsURL(fromDepartment department: Department) {
        self.departmentURL = Link.departmentURL + String(department.departmentId)
    }

    func getObjectsIDs(forCell cell: DepartmentsViewCell) {


        guard !isParsing else { return }
        isParsing = true

        networkManager.fetchObjects(Objects.self, from: departmentURL) { [weak self] result in
            switch result {
            case .success(let objects):
                DispatchQueue.main.async {
                    self?.router.routeTo(target: DepartmentsRouter.Target.randomArt(imageIDs: objects.objectIDs))
                    cell.stopAnimating()
                    self?.isParsing = false
                }
            case .failure(let error):
                print(error.localizedDescription)

                DispatchQueue.main.async {
                    guard let self = self else { return }

                    self.networkManager.alertAction() {
                        cell.stopAnimating()
                        self.isParsing = false
                    }
                }
            }
        }
    }

    func getParsingStatus() -> Bool {
        print("Current status: \(isParsing)")
        return isParsing
    }

    func resetParsingStatus() {
        isParsing = false
    }
}

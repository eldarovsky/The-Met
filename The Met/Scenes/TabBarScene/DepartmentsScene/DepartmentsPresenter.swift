//
//  DepartmentsPresenter.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 18.02.2024.
//

import Foundation

protocol DepartmentsPresenterProtocol {
    func getDepartmentsID()
    func getDepartmentsURL(fromDepartment department: Department)
    func getObjectsIDs(forCell cell: DepartmentsViewCell)
    //    func getParcingStatus() -> Bool
    //    func toggleParcingStatus()
}

final class DepartmentsPresenter {
    weak var view: DepartmentsViewControllerProtocol?
    let router: DepartmentsRouterProtocol

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
        networkManager.fetchObjects(Objects.self, from: departmentURL) { [weak self] result in
            switch result {
            case .success(let objects):
                DispatchQueue.main.async {
                    self?.router.routeTo(target: DepartmentsRouter.Target.randomArt(imageIDs: objects.objectIDs))
                    cell.stopAnimating()
                }
            case .failure(let error):
                print(error.localizedDescription)

                DispatchQueue.main.async {
                    guard let self = self else { return }

                    self.networkManager.alertAction() {
                        self.isParsing = false
                         cell.stopAnimating()
                    }
                }
            }
        }
    }

    //    func getParcingStatus() -> Bool {
    //        isParsing
    //    }

    //    func toggleParcingStatus() {
    //        isParsing.toggle()
    //    }
}

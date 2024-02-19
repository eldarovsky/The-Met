//
//  DepartmentsViewController.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 03.01.2024.
//

import UIKit

protocol DepartmentsViewControllerProtocol: AnyObject {}

final class DepartmentsViewController: UIViewController {
    var presenter: DepartmentsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}

extension DepartmentsViewController: DepartmentsViewControllerProtocol {}

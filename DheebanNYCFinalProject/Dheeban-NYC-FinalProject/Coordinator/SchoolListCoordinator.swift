//
//  SchoolListCoordinator.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.


import UIKit

class SchoolListCoordinator: Coordinator {
    static let shared = SchoolListCoordinator()

    var navigationController: UINavigationController

    private init() {
        self.navigationController = UINavigationController()
    }

    func start() {
        let schoolListViewController = SchoolListViewController()
        schoolListViewController.coordinator = self
        navigationController.pushViewController(schoolListViewController, animated: true)
    }

    func showSchoolDetails(school: NYCSchoolModel, satDetails: NYCSchoolSATModel?) {
        let schoolDetailViewController = SchoolDetailViewController(school: school, satDetails: satDetails)
        navigationController.pushViewController(schoolDetailViewController, animated: true)
    }
}

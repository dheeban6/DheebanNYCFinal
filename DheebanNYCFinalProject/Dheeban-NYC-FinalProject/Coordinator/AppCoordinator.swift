//
//  AppCoordinator.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

// AppCoordinator.swift

import UIKit

class AppCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let homeViewController = HomeViewController() // No arguments passed
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func navigateToSchoolList() {
        let schoolListCoordinator = SchoolListCoordinator.shared
        schoolListCoordinator.navigationController = navigationController
        schoolListCoordinator.start()
    }
}

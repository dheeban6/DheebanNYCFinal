//
//  AppCoordinator.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import UIKit

class AppCoordinator {
    private let navigationController: UINavigationController
    private var homeViewModel: HomeViewModel

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.homeViewModel = HomeViewModel()
        self.homeViewModel.coordinator = self
    }

    func start() {
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        navigationController.pushViewController(homeViewController, animated: true)
    }
    func navigateToSchoolList(schools: [NYCSchoolModel], satDetails: [NYCSchoolSATModel]) {
            // Navigate to SchoolListViewController
            let schoolListCoordinator = SchoolListCoordinator(
                navigationController: self.navigationController,
                schools: schools,
                satDetails: satDetails
            )
            schoolListCoordinator.start()
        }
}

//
//  SchoolListCoordinator.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import UIKit

class SchoolListCoordinator {
    private let navigationController: UINavigationController
    private let schools: [NYCSchoolModel]
    private let satDetails: [NYCSchoolSATModel]

    // Accept the fetched data from HomeViewModel
    init(navigationController: UINavigationController, schools: [NYCSchoolModel], satDetails: [NYCSchoolSATModel]) {
        self.navigationController = navigationController
        self.schools = schools
        self.satDetails = satDetails
    }
    
    func start() {
        // Pass fetched data to SchoolListViewModel
        let viewModel = SchoolListViewModel(schools: schools, satDetails: satDetails)
        let schoolListVC = SchoolListViewController(viewModel: viewModel)
        schoolListVC.coordinator = self
        navigationController.pushViewController(schoolListVC, animated: false)
    }
    
    func showSchoolDetails(school: NYCSchoolModel, satDetails: NYCSchoolSATModel?) {
        let viewModel = SchoolDetailViewModel(school: school, satDetails: satDetails)
        let schoolDetailVC = SchoolDetailViewController(schoolInfo: school, schoolSATDetails: satDetails)
        navigationController.pushViewController(schoolDetailVC, animated: true)
    }
}

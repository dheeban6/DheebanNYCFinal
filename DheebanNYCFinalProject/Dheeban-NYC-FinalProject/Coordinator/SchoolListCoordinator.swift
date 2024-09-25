//
//  SchoolListCoordinator.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import UIKit

class SchoolListCoordinator: Coordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SchoolListViewModel()
        let schoolListVC = SchoolListViewController(viewModel: viewModel)
        schoolListVC.coordinator = self
        navigationController.pushViewController(schoolListVC, animated: false)
    }
    
    func showSchoolDetails(school: NYCSchoolModel, satDetails: NYCSchoolSATModel?) {
        print("\(school)")
        print("SAT deyails\(satDetails)")
        let viewModel = SchoolDetailViewModel(school: school, satDetails: satDetails)
        let schoolDetailVC = SchoolDetailViewController(schoolInfo: school, schoolSATDetails: satDetails)
        navigationController.pushViewController(schoolDetailVC, animated: true)
    }
}


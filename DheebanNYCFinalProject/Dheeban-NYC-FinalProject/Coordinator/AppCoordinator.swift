//
//  AppCoordinator.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private var schoolListCoordinator: SchoolListCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let homeViewModel = HomeViewModel()
        let homeVC = HomeViewController(viewModel: homeViewModel)
        homeVC.coordinator = self
        
        let navController = UINavigationController(rootViewController: homeVC)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    func showSchoolList() {
        let navigationController = UINavigationController()
        schoolListCoordinator = SchoolListCoordinator(navigationController: navigationController)
        schoolListCoordinator?.start()
        
        // Switch from HomeViewController to SchoolListViewController
        window.rootViewController = navigationController
    }
}

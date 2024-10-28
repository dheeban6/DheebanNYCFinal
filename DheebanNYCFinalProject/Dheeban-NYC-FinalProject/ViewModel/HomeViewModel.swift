//
//  HomeViewModel.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.

import Foundation
import Combine

class HomeViewModel {
    private var cancellables = Set<AnyCancellable>()
    @Published var isLoading = false
    var coordinator: AppCoordinator?
    
    // Fetch data using NYCSchoolDataProvider
    func fetchData(completion: @escaping () -> Void) {
        isLoading = true
        NYCSchoolDataProvider.shared.fetchData {
            self.isLoading = false
            completion()
        }
    }
    
    // Navigation to school list
    func navigateToSchoolList() {
        coordinator?.navigateToSchoolList()
    }
}

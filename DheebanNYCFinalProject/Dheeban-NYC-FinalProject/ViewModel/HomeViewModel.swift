//
//  HomeViewModel.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import Foundation
import Combine

import Foundation
import Combine

class HomeViewModel {
    private let schoolService: NYCSchoolServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    @Published var isLoading = false
    var coordinator: AppCoordinator?
    // Store fetched data to be passed to SchoolListViewModel
    var fetchedSchools: [NYCSchoolModel] = []
    var fetchedSATDetails: [NYCSchoolSATModel] = []

    init(schoolService: NYCSchoolServiceProtocol = NYCSchoolService()) {
        self.schoolService = schoolService
    }
    
    func fetchData(completion: @escaping () -> Void) {
        isLoading = true
        
        let schoolPublisher = schoolService.fetchSchoolList()
        let satPublisher = schoolService.fetchSATDetails()
        
        // Fetch both schools and SAT data concurrently
        Publishers.Zip(schoolPublisher, satPublisher)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionStatus in
                self.isLoading = false
                if case .failure(let error) = completionStatus {
                    print("Error: \(error)")
                } else {
                    // Data fetched successfully
                    completion()  // Notify the coordinator to navigate to school list
                }
            }, receiveValue: { [weak self] schools, sats in
                self?.fetchedSchools = schools    // Store fetched schools
                self?.fetchedSATDetails = sats    // Store fetched SAT data
            })
            .store(in: &cancellables)
    }
    // Use this method to trigger navigation when needed
    func navigateToSchoolList() {
        coordinator?.navigateToSchoolList(schools: fetchedSchools, satDetails: fetchedSATDetails)
    }
}

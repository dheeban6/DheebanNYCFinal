//
//  HomeViewModel.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import Foundation
import Combine

class HomeViewModel {
    private let schoolService: NYCSchoolServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    @Published var isLoading = false
    
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
                    completion()  // Navigate to school list
                }
            }, receiveValue: { schools, sats in
                // You can handle the fetched data here if needed
            })
            .store(in: &cancellables)
    }
}

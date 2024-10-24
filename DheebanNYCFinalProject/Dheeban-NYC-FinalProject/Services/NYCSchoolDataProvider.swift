//
//  NYCSchoolDataProvider.swift
//  DheebanNYCFinalProject
//
//  Created by Dheeban Jaga on 10/24/24.
//

import Foundation
import Combine

class NYCSchoolDataProvider {
    static let shared = NYCSchoolDataProvider()
    
    private var cancellables = Set<AnyCancellable>()
    private let schoolService: NYCSchoolServiceProtocol
    
    @Published var schools: [NYCSchoolModel] = []
    @Published var satDetails: [NYCSchoolSATModel] = []
    
    private init(schoolService: NYCSchoolServiceProtocol = NYCSchoolService()) {
        self.schoolService = schoolService
    }
    
    func fetchData(completion: @escaping () -> Void) {
        let schoolPublisher = schoolService.fetchSchoolList()
        let satPublisher = schoolService.fetchSATDetails()
        
        Publishers.Zip(schoolPublisher, satPublisher)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionStatus in
                if case .failure(let error) = completionStatus {
                    print("Failed to fetch data: \(error)")
                } else {
                    completion()
                }
            }, receiveValue: { [weak self] schools, satDetails in
                self?.schools = schools
                self?.satDetails = satDetails
            })
            .store(in: &cancellables)
    }
    
    func getSATDetails(for dbn: String) -> NYCSchoolSATModel? {
        return satDetails.first { $0.dbn == dbn }
    }
    func getSchool(by dbn: String) -> NYCSchoolModel? {
          return schools.first { $0.dbn == dbn }
      }
}

//
//  SchoolListViewModel.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import Foundation
import Combine

class SchoolListViewModel {
    private var schoolService: NYCSchoolServiceProtocol
    @Published var schools: [NYCSchoolModel] = []
    var satDetailsList: [NYCSchoolSATModel] = []
    var allSchools: [NYCSchoolModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(schoolService: NYCSchoolServiceProtocol = NYCSchoolService()) {
        self.schoolService = schoolService
    }
    
    // Fetch both the school list and SAT details
        func fetchSchoolsAndSATDetails() {
            let schoolPublisher = schoolService.fetchSchoolList()
            let satPublisher = schoolService.fetchSATDetails()
            
            Publishers.Zip(schoolPublisher, satPublisher)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Error fetching data: \(error)")
                    }
                }, receiveValue: { [weak self] schools, satDetails in
                    self?.allSchools = schools // Store the full list of schools
                    self?.schools = schools
                    self?.satDetailsList = satDetails
                })
                .store(in: &cancellables)
        }
    
    func numberOfSchools() -> Int {
        return schools.count
    }
    
    func school(at index: Int) -> NYCSchoolModel {
        return schools[index]
    }
    
    // Function to get SAT details for a school based on the dbn
    func satDetails(for dbn: String) -> NYCSchoolSATModel? {
        return satDetailsList.first { $0.dbn == dbn }
    }
    
    func filterSchools(by searchText: String) {
        if searchText.isEmpty {
            schools = allSchools
            
        } else {
            schools = allSchools.filter { $0.school_name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func sortBySchoolName(ascending: Bool) {
        schools = schools.sorted(by: { ascending ? $0.school_name < $1.school_name : $0.school_name > $1.school_name })
    }
    
    func sortByCity(ascending: Bool) {
        schools = schools.sorted(by: { ascending ? $0.city < $1.city : $0.city > $1.city })
    }
}

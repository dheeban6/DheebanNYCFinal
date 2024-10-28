//
//  SchoolListViewModel.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.

import Foundation
import Combine

class SchoolListViewModel {
    @Published var schools: [NYCSchoolModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Subscribe to updates from NYCSchoolDataProvider
        NYCSchoolDataProvider.shared.$schools
            .receive(on: DispatchQueue.main)
            .sink { [weak self] schools in
                self?.schools = schools
            }
            .store(in: &cancellables)
    }
    
    func numberOfSchools() -> Int {
        return schools.count
    }
    
    func school(at index: Int) -> NYCSchoolModel {
        return schools[index]
    }
    
    // Sorting functions
    func sortBySchoolName(ascending: Bool) {
        schools.sort { ascending ? $0.school_name < $1.school_name : $0.school_name > $1.school_name }
    }
    
    func sortByCity(ascending: Bool) {
        schools.sort { ascending ? $0.city < $1.city : $0.city > $1.city }
    }
}

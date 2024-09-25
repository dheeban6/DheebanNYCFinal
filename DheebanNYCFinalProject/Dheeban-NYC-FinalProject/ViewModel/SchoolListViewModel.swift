//
//  SchoolListViewModel.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import Foundation
import Combine

import Foundation
import Combine

class SchoolListViewModel {
    @Published var schools: [NYCSchoolModel] = []
    var satDetailsList: [NYCSchoolSATModel] = []
    var allSchools: [NYCSchoolModel] = []

    // Accept data passed from HomeViewModel
    init(schools: [NYCSchoolModel], satDetails: [NYCSchoolSATModel]) {
        self.allSchools = schools
        self.schools = schools
        self.satDetailsList = satDetails
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

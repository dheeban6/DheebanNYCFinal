//
//  SchoolDetailViewModel.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.

import Foundation
import Combine

class SchoolDetailViewModel {
    private var school: NYCSchoolModel
    @Published var schoolName: String
    @Published var satReadingScore: String
    @Published var satMathScore: String
    @Published var satWritingScore: String
    @Published var overview: String
    @Published var phoneNumber: String
    @Published var website: String
    
    private var cancellables = Set<AnyCancellable>()
    
    init(school: NYCSchoolModel) {
        self.school = school
        self.schoolName = school.school_name
        self.overview = school.overview_paragraph ?? "No overview available"
                self.phoneNumber = school.phone_number ?? "No phone number available"
                self.website = school.website ?? "No website available"
        
        // Retrieve SAT details using the data provider
        if let satDetails = NYCSchoolDataProvider.shared.getSATDetails(for: school.dbn) {
            self.satReadingScore = "SAT Average Reading Score: \(satDetails.sat_critical_reading_avg_score ?? "N/A")"
            self.satMathScore = "SAT Average Math Score: \(satDetails.sat_math_avg_score ?? "N/A")"
            self.satWritingScore = "SAT Average Writing Score: \(satDetails.sat_writing_avg_score ?? "N/A")"
        } else {
            self.satReadingScore = "SAT Average Reading Score: N/A"
            self.satMathScore = "SAT Average Math Score: N/A"
            self.satWritingScore = "SAT Average Writing Score: N/A"
        }
    }
}

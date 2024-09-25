//
//  SchoolDetailViewModel.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import Foundation
class SchoolDetailViewModel {
    private let school: NYCSchoolModel
    private let satDetails: NYCSchoolSATModel?
    
    init(school: NYCSchoolModel, satDetails: NYCSchoolSATModel?) {
        self.school = school
        self.satDetails = satDetails
    }
    
    var schoolName: String {
        return school.school_name
    }
    
    var overview: String {
        return school.overview_paragraph ?? "Overview not available"
    }
    
    var contactInfo: String {
        return "Phone: \(school.phone_number ?? "N/A")\nEmail: \(school.school_email ?? "N/A")"
    }
    
    var satReadingScore: String {
        return "Reading: \(satDetails?.sat_critical_reading_avg_score ?? "N/A")"
    }
    
    var satMathScore: String {
        return "Math: \(satDetails?.sat_math_avg_score ?? "N/A")"
    }
    
    var satWritingScore: String {
        return "Writing: \(satDetails?.sat_writing_avg_score ?? "N/A")"
    }
}

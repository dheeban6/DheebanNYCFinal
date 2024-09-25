//
//  MockNYCSchoolService.swift
//  Dheeban-NYC-FinalProjectTests
//
//  Created by Dheeban Jaga on 9/24/24.
//
import XCTest
import Combine
@testable import DheebanNYCFinalProject
class MockNYCSchoolService: NYCSchoolServiceProtocol {
    
    func fetchSchoolList() -> AnyPublisher<[NYCSchoolModel], Error> {
        let schools = mockSchoolData()
        return Just(schools)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchSATDetails() -> AnyPublisher<[NYCSchoolSATModel], Error> {
        let satDetails = mockSATData()
        return Just(satDetails)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    // Mock school data with all required parameters filled in
    func mockSchoolData() -> [NYCSchoolModel] {
        return [
            NYCSchoolModel(
                dbn: "01A",
                school_name: "Sample School 1",
                overview_paragraph: "A great school for students.",  // Required
                neighborhood: "Manhattan",                          // Required
                phone_number: "123-456-7890",                       // Required
                school_email: "info@school1.edu",                   // Required
                borough: "Manhattan",
                city: "New York",
                website: "www.school1.edu" // Required
            ),
            NYCSchoolModel(
                dbn: "02B",
                school_name: "Sample School 2",
                overview_paragraph: "An excellent school with a focus on science.",  // Required
                neighborhood: "Brooklyn",                                        // Required
                phone_number: "987-654-3210",                                    // Required
                school_email: "info@school2.edu",                                // Required
                borough: "Brooklyn",                      // Required
                city: "Brooklyn",
                website: "www.school2.edu"   // Required
            )
        ]
    }

    func mockSATData() -> [NYCSchoolSATModel] {
        return [
            NYCSchoolSATModel(
                dbn: "01A",
                school_name: "Sample School 1",
                num_of_sat_test_takers: "100",    // Provide the number of SAT test takers
                sat_critical_reading_avg_score: "400",
                sat_math_avg_score: "500",
                sat_writing_avg_score: "450"
            ),
            NYCSchoolSATModel(
                dbn: "02B",
                school_name: "Sample School 2",
                num_of_sat_test_takers: "80",     // Provide the number of SAT test takers
                sat_critical_reading_avg_score: "420",
                sat_math_avg_score: "480",
                sat_writing_avg_score: "430"
            )
        ]
    }
}

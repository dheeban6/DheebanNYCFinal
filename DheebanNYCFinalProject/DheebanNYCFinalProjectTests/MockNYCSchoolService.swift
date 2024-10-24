//
//  MockNYCSchoolService.swift
//  Dheeban-NYC-FinalProjectTests
//
//  Created by Dheeban Jaga on 9/24/24.
//
import Foundation
import Combine
@testable import DheebanNYCFinalProject

class MockNYCSchoolService: NYCSchoolServiceProtocol {
    func fetchSchoolList() -> AnyPublisher<[NYCSchoolModel], Error> {
        let mockSchools = [
            NYCSchoolModel(dbn: "01M292", school_name: "Sample School 1", overview_paragraph: "Overview 1", neighborhood: "Neighborhood 1", phone_number: "1234567890", school_email: "school1@example.com", borough: "Manhattan", city: "New York", website: "www.school1.com"),
            NYCSchoolModel(dbn: "02M123", school_name: "Sample School 2", overview_paragraph: "Overview 2", neighborhood: "Neighborhood 2", phone_number: "0987654321", school_email: "school2@example.com", borough: "Manhattan", city: "New York", website: "www.school2.com")
        ]
        return Just(mockSchools)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchSATDetails() -> AnyPublisher<[NYCSchoolSATModel], Error> {
        let mockSATDetails = [
            NYCSchoolSATModel(dbn: "01M292", school_name: "Sample School 1", num_of_sat_test_takers: "Sat 1", sat_critical_reading_avg_score: "400", sat_math_avg_score: "450", sat_writing_avg_score: "420"),
            NYCSchoolSATModel(dbn: "02M123", school_name: "Sample School 2", num_of_sat_test_takers: "Sat 2",sat_critical_reading_avg_score: "390", sat_math_avg_score: "400", sat_writing_avg_score: "410")
        ]
        return Just(mockSATDetails)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

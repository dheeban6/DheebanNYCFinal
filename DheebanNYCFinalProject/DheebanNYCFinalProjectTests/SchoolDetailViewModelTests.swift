//
//  SchoolDetailViewModelTests.swift
//  DheebanNYCFinalProjectTests
//
//  Created by Dheeban Jaga on 10/24/24.
//

import XCTest
import Combine // Import Combine to use AnyCancellable
@testable import DheebanNYCFinalProject

class SchoolDetailViewModelTests: XCTestCase {
    var viewModel: SchoolDetailViewModel!
    var mockService: MockNYCSchoolService!
    var mockSchool: NYCSchoolModel!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        // Initialize the mock service
        mockService = MockNYCSchoolService()
        
        // Use the mock service to get a mock school
        mockService.fetchSchoolList()
            .sink(receiveCompletion: { _ in }, receiveValue: { schools in
                self.mockSchool = schools.first
            })
            .store(in: &cancellables)
        
        // Initialize the SchoolDetailViewModel with the mock school
        guard let school = mockSchool else {
            XCTFail("Failed to get mock school from service")
            return
        }
        
        viewModel = SchoolDetailViewModel(school: school)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockSchool = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testViewModelInitialization() {
        // Assert that the viewModel's properties are set correctly
        XCTAssertEqual(viewModel.schoolName, mockSchool.school_name, "School name should match the mock data")
        XCTAssertEqual(viewModel.overview, mockSchool.overview_paragraph, "Overview should match the mock data")
        XCTAssertEqual(viewModel.phoneNumber, mockSchool.phone_number, "Phone number should match the mock data")
        XCTAssertEqual(viewModel.website, mockSchool.website, "Website should match the mock data")
    }
}

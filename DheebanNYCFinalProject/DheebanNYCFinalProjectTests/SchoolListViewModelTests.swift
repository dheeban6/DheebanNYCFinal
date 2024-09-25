//
//  SchoolListViewModelTests.swift
//  Dheeban-NYC-FinalProjectTests
//
//  Created by Dheeban Jaga on 9/24/24.
//

import XCTest
@testable import DheebanNYCFinalProject

class SchoolListViewModelTests: XCTestCase {
    
    var viewModel: SchoolListViewModel!
    var mockService: MockNYCSchoolService!
    
    override func setUp() {
        super.setUp()
        mockService = MockNYCSchoolService()
        viewModel = SchoolListViewModel(schoolService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    // Test initial state
    func testInitialState() {
        XCTAssertTrue(viewModel.schools.isEmpty)
    }
    
    // Test fetching schools and SAT details
    func testFetchSchoolsAndSATDetails() {
        // Given
        let expectation = XCTestExpectation(description: "Schools and SAT data fetched")
        
        // When
        viewModel.fetchSchoolsAndSATDetails()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.schools.count, 2) // Assuming mockService returns 2 schools
            XCTAssertEqual(self.viewModel.satDetailsList.count, 2) // Assuming mockService returns 2 SAT details
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test filtering schools by name
    func testFilterSchoolsByName() {
        viewModel.allSchools = mockService.mockSchoolData()
        viewModel.filterSchools(by: "Sample School 1")
        XCTAssertEqual(viewModel.schools.count, 1)
        XCTAssertEqual(viewModel.schools.first?.school_name, "Sample School 1")
    }
    
    // Test sorting schools by name
    func testSortBySchoolName() {
        // Given
        let mockService = MockNYCSchoolService()
        let viewModel = SchoolListViewModel(schoolService: mockService)
        
        // Populate the schools array with mock data
        viewModel.allSchools = mockService.mockSchoolData()  // Ensure this is called before sorting
        viewModel.schools = viewModel.allSchools              // Sync allSchools to schools for initial state
        
        // When (Sorting schools by name in ascending order)
        viewModel.sortBySchoolName(ascending: true)
        
        // Then
        XCTAssertEqual(viewModel.schools.first?.school_name, "Sample School 1")  // Check sorted order
    }
    
    // Test sorting schools by city
    func testSortByCity() {
        // Given
        let mockService = MockNYCSchoolService()
        let viewModel = SchoolListViewModel(schoolService: mockService)
        
        // Populate the schools array with mock data
        viewModel.allSchools = mockService.mockSchoolData()  // Ensure mock data is loaded
        viewModel.schools = viewModel.allSchools              // Sync allSchools to schools for initial state
        
        // When (Sorting schools by city in ascending order)
        viewModel.sortByCity(ascending: true)
        
        // Then
        XCTAssertEqual(viewModel.schools.first?.city, "Brooklyn")  // Check if sorted correctly by city
    }
}


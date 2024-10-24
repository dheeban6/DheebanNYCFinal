//
//  SchoolListViewModelTests.swift
//  Dheeban-NYC-FinalProjectTests
//
//  Created by Dheeban Jaga on 9/24/24.
//

import XCTest
import Combine
@testable import DheebanNYCFinalProject

class SchoolListViewModelTests: XCTestCase {
    var viewModel: SchoolListViewModel!
    var mockDataProvider: NYCSchoolDataProvider!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        // Initialize the mock data provider
        mockDataProvider = NYCSchoolDataProvider.shared
        
        // Initialize the view model without passing the data provider
        viewModel = SchoolListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        mockDataProvider = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testFetchSchools() {
        // Simulate fetching data using the mock data provider
        mockDataProvider.fetchData {
            // Assign the schools to the view model
            self.viewModel.schools = self.mockDataProvider.schools
            
            // Assert that the data is fetched and not empty
            XCTAssertFalse(self.viewModel.schools.isEmpty, "Fetched schools should not be empty")
            
            // Validate the first school's name matches the expected value
            let firstSchool = self.viewModel.schools.first
            XCTAssertEqual(firstSchool?.school_name, "Sample School 1", "First school name should match the mock data")
        }
    }
    
    func testSortingByName() {
        // Test sorting functionality
        self.viewModel.schools = mockDataProvider.schools
        viewModel.sortBySchoolName(ascending: true)
        
        // Assert that the list is sorted in ascending order
        XCTAssertTrue(self.viewModel.schools.first?.school_name ?? "" < self.viewModel.schools.last?.school_name ?? "", "Schools should be sorted by name in ascending order")
    }
}

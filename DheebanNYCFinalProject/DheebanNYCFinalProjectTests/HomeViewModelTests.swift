//
//  HomeViewModelTests.swift
//  DheebanNYCFinalProjectTests
//
//  Created by Dheeban Jaga on 10/24/24.
//

import XCTest
import Combine
@testable import DheebanNYCFinalProject

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchData() {
        // Create an expectation for the async data fetch
        let expectation = XCTestExpectation(description: "Data should be fetched from the provider")

        // Observe the NYCSchoolDataProvider.shared's schools and SAT details
        NYCSchoolDataProvider.shared.$schools
            .combineLatest(NYCSchoolDataProvider.shared.$satDetails)
            .sink(receiveValue: { schools, satDetails in
                // Once data is received, validate it
                if !schools.isEmpty && !satDetails.isEmpty {
                    XCTAssertFalse(schools.isEmpty, "Fetched schools should not be empty")
                    XCTAssertFalse(satDetails.isEmpty, "Fetched SAT details should not be empty")
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)

        // Trigger the data fetching
        viewModel.fetchData {
            // Completion handler when data fetching is done
        }

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
}

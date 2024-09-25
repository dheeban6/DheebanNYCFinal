//
//  NYCSchoolServiceTests.swift
//  Dheeban-NYC-FinalProjectTests
//
//  Created by Dheeban Jaga on 9/24/24.
//
import XCTest
@testable import DheebanNYCFinalProject
class NYCSchoolServiceTests: XCTestCase {
    
    var service: NYCSchoolService!
    
    override func setUp() {
        super.setUp()
        service = NYCSchoolService()
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
    
    // Test fetching schools (mocking network call)
    func testFetchSchoolList() {
        let expectation = XCTestExpectation(description: "Fetch school list from network")
        
        let cancellable = service.fetchSchoolList()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed to fetch school list: \(error)")
                }
            }, receiveValue: { schools in
                XCTAssertGreaterThan(schools.count, 0) // Ensure we got some data
                expectation.fulfill()
            })
        
        wait(for: [expectation], timeout: 5.0)
        cancellable.cancel()
    }
    
    // Test fetching SAT details (mocking network call)
    func testFetchSATDetails() {
        let expectation = XCTestExpectation(description: "Fetch SAT details from network")
        
        let cancellable = service.fetchSATDetails()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed to fetch SAT details: \(error)")
                }
            }, receiveValue: { satDetails in
                XCTAssertGreaterThan(satDetails.count, 0) // Ensure we got some data
                expectation.fulfill()
            })
        
        wait(for: [expectation], timeout: 5.0)
        cancellable.cancel()
    }
}


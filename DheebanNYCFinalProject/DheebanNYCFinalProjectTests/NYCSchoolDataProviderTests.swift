//
//  NYCSchoolDataProviderTests.swift
//  DheebanNYCFinalProjectTests
//
//  Created by Dheeban Jaga on 10/24/24.
//

import XCTest
import Combine
@testable import DheebanNYCFinalProject

final class NYCSchoolDataProviderTests: XCTestCase {
    var dataProvider: NYCSchoolDataProvider!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        dataProvider = NYCSchoolDataProvider.shared
    }

    override func tearDown() {
        cancellables = []
        dataProvider = nil
        super.tearDown()
    }

    func testFetchData() {
        let expectation = self.expectation(description: "Data fetch should succeed")
        dataProvider.fetchData {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}

//
//  PICeTimerTests.swift
//  PICeTimerTests
//
//  Created by Adrian Ward on 21/07/2019.
//  Copyright © 2019 Adrian Ward. All rights reserved.
//

import XCTest
@testable import PICeTimer

class ConcernAPITests: XCTestCase {
    var api: ConcernAPIService?

    override func setUp() {
        api = ConcernAPIService()
    }

    override func tearDown() {
        api = nil
    }

    func testDummyDate() {
        XCTAssert(api?.concerns.count == 20)
    }

    func testAppDependencies() {
        let dependences = AppDependencies()
        XCTAssert(dependences.apiService.concerns.count == 20)
    }

}

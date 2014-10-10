//
//  ScrollHelpersTests.swift
//  ScrollHelpersTests
//
//  Created by Zef Houssney on 10/7/14.
//

import UIKit
import XCTest

class ScrollHelpersTests: XCTestCase {
        var helper = ScrollHelper()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        helper.targetOffset = 100
        helper.triggerDistance = helper.targetOffset/2
        helper.direction = .All
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDistance() {
        helper.offset = 0
        XCTAssertEqual(helper.distanceToTarget(), -100)

        helper.offset = 25
        XCTAssertEqual(helper.distanceToTarget(), -75)

        helper.offset = 100
        XCTAssertEqual(helper.distanceToTarget(), 0)

        helper.offset = 125
        XCTAssertEqual(helper.distanceToTarget(), 25)
    }

    func testPercentageForBothDirections() {
        helper.offset = 0
        XCTAssertEqual(helper.percentage(), 0)

        helper.offset = 90
        XCTAssertEqualWithAccuracy(helper.percentage(), 0.8, 0.001)

        helper.offset = 100
        XCTAssertEqual(helper.percentage(), 1)

        helper.offset = 110
        XCTAssertEqualWithAccuracy(helper.percentage(), 0.8, 0.001)

        helper.offset = 150
        XCTAssertEqual(helper.percentage(), 0)

        helper.offset = 1000
        XCTAssertEqual(helper.percentage(), 0)
    }

    func testPercentageForIn() {
        helper.direction = .In
        helper.offset = 0
        XCTAssertEqual(helper.percentage(), 0)

        helper.offset = 75
        XCTAssertEqual(helper.percentage(), 0.5)

        helper.offset = 100
        XCTAssertEqual(helper.percentage(), 1)

        helper.offset = 125
        XCTAssertEqual(helper.percentage(), 1)

        helper.offset = 1000
        XCTAssertEqual(helper.percentage(), 1)
    }
    
    }
    
}

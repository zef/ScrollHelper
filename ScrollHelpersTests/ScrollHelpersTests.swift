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
    
    func testPercentageForOut() {
        helper.direction = .Out
        helper.offset = 0
        XCTAssertEqual(helper.percentage(), 1)

        helper.offset = 75
        XCTAssertEqual(helper.percentage(), 1)

        helper.offset = 100
        XCTAssertEqual(helper.percentage(), 1)

        helper.offset = 125
        XCTAssertEqual(helper.percentage(), 0.5)

        helper.offset = 150
        XCTAssertEqual(helper.percentage(), 0)

        helper.offset = 1000
        XCTAssertEqual(helper.percentage(), 0)
    }

    func testReversePercentage() {
        helper.offset = 90
        XCTAssertEqualWithAccuracy(helper.reversePercentage(), 0.2, 0.001)
    }

    func testDirectionParamInPercentage() {
        helper.offset = 125
        XCTAssertEqual(helper.percentage(), 0.5)
        XCTAssertEqual(helper.percentage(.All), 0.5)
        XCTAssertEqual(helper.percentage(.Out), 0.5)

        XCTAssertEqual(helper.percentage(.In), 1)
        XCTAssertEqual(helper.reversePercentage(.In), 0)
    }

    func testDirectionalTriggerDistance() {
        helper.triggerDistanceIn = 50
        helper.triggerDistanceOut = 100

//        XCTAssertNil(helper.triggerDistance?, "Trigger distance should be nil if in and out are different")
//        helper.triggerDistanceOut = 50
//        XCTAssertEqual(helper.triggerDistance!, 50, "Trigger distance should be set if in and out are equal")

        helper.offset = 90
        XCTAssertEqualWithAccuracy(helper.percentage(), 0.8, 0.001)

        helper.offset = 110
        XCTAssertEqualWithAccuracy(helper.percentage(), 0.9, 0.001)

    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
////        self.measureBlock() {
////            // Put the code you want to measure the time of here.
////        }
//    }
}

//
//  ScrollHelper.swift
//  ScrollTriggers
//
//  Created by Zef Houssney on 10/7/14.
//

import UIKit
import Foundation

//
//  ScrollHelper.swift
//  ScrollTriggers
//
//  Created by Josef Houssney on 10/7/14.
//  Copyright (c) 2014 Made By Kiwi. All rights reserved.
//

import UIKit
import Foundation

struct ScrollHelper {
    enum Direction {
        case In, Out, All
        // just realized could add these with trigger distances too.
        // Something like this:
        // case InAt(CGFloat)
        // case OutAt(CGFloat)
        // case AllAt(CGFloat, CGFloat)
        // I was hoping to use the same name with an optional arg,
        // but that doesn't seem to be supported
    }

    private(set) var previousOffset: CGFloat = 0

    var offset: CGFloat = 0  {
        willSet {
            previousOffset = offset
        }
    }
    var targetOffset: CGFloat = 0
    var direction = Direction.All

    // should be write only or use a function or something
    // don't have time to figure it out right now...
    var triggerDistance: CGFloat? = 0 {
        didSet {
            if let distance = triggerDistance? {
                triggerDistanceIn = distance
                triggerDistanceOut = distance
            }
        }
    }
    var triggerDistanceIn: CGFloat = 0
    var triggerDistanceOut: CGFloat = 0

    // returns the number of points from the target location
    // negative numbers indicate that the target has not been reached
    // positive numbers indicate the distance past the target
    func distanceToTarget() -> CGFloat {
        return offset - targetOffset
    }

    func percentage(_ customDirection: Direction? = nil) -> CGFloat {
        var direction = customDirection == nil ? self.direction : customDirection!
        var distance = distanceToTarget()

        var percentage = CGFloat(0)
        if distance < 0 {
            percentage = CGFloat(1.0 - (abs(distance)/triggerDistanceIn))
        } else {
            percentage = CGFloat(1.0 - (abs(distance)/triggerDistanceOut))
        }

        percentage = max(percentage, 0)

        switch direction {
        case .In:
            return distance > 0.0 ? 1 : percentage
        case .Out:
            return distance < 0.0 ? 1 : percentage
        case .All:
            return percentage
        }
    }

    func reversePercentage(_ customDirection: Direction? = nil) -> CGFloat {
        return 1 - percentage(customDirection)
    }
}
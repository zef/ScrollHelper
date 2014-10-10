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
        case Arriving, Leaving, All
    }

    var offset: Float = 0
    var targetOffset: Float = 0
    var direction = Direction.All

    var triggerDistance: Float = 0

    // returns the number of points from the target location
    // negative numbers indicate that the target has not been reached
    // positive numbers indicate the distance past the target
    func distanceToTarget() -> Float {
        return offset - targetOffset
    }

    func percentage() -> CGFloat {
        var distance = distanceToTarget()
        var percentage = CGFloat(1.0 - (abs(distance)/triggerDistance))
        percentage = max(percentage, 0)

        println(distance)
        println(triggerDistance)
        println(percentage)

        switch direction {
        case .Arriving:
            return distance > 0.0 ? 1 : percentage
        case .Leaving:
            return distance < 0.0 ? 1 : percentage
        case .All:
            return percentage
        }
    }

}

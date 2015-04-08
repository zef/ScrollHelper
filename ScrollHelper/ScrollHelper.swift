//
//  ScrollHelper.swift
//
//  Created by Zef Houssney on 10/7/14.
//

import UIKit
import Foundation

struct ScrollHelper {
    enum Direction {
        case Ascending, Descending, Any
    }

    enum Side {
        case In, Out, Any
        // just realized could add these with trigger distances too.
        // Something like this:
        // case InAt(CGFloat)
        // case OutAt(CGFloat)
        // case AnyAt(CGFloat, CGFloat)
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
    var side = Side.Any

    // should be write only or use a function or something
    // don't have time to figure it out right now...
    var triggerDistance: CGFloat? = 0 {
        didSet {
            if let distance = triggerDistance {
                triggerDistanceIn = distance
                triggerDistanceOut = distance
            }
        }
    }
    var triggerDistanceIn: CGFloat = 0
    var triggerDistanceOut: CGFloat = 0

    // this does not store a trigger that is set once, but is meant to be called 
    // each time after setting the offset, like in scrollViewDidScroll
    func triggerAt(location: CGFloat, _ block: ((Direction) -> ()), direction: Direction = .Any) {
        var valueChanged = self.previousOffset != self.offset
        var valuesSpanLocation = (self.previousOffset < location) != (self.offset < location)
        var valueTouchesLocation = self.previousOffset == location || self.offset == location

        if  valueChanged && (valuesSpanLocation || valueTouchesLocation) {
            var currentDirection = scrollDirection()
            switch direction {
            case .Ascending:
                if scrollDirection() == .Ascending {
                    block(scrollDirection())
                }
            case .Descending:
                if scrollDirection() == .Descending {
                    block(scrollDirection())
                }
            case .Any:
                block(scrollDirection())
            }
        }
    }

    func scrollDirection() -> Direction {
        return self.previousOffset < self.offset ? .Ascending : .Descending
    }

    // returns the number of points from the target location
    // negative numbers indicate that the target has not been reached
    // positive numbers indicate the distance past the target
    func distanceToTarget() -> CGFloat {
        return offset - targetOffset
    }

    func percentage(_ customSide: Side? = nil) -> CGFloat {
        var side = customSide == nil ? self.side : customSide!
        var distance = distanceToTarget()

        var percentage = CGFloat(0)
        if distance < 0 {
            percentage = CGFloat(1.0 - (abs(distance)/triggerDistanceIn))
        } else {
            percentage = CGFloat(1.0 - (abs(distance)/triggerDistanceOut))
        }

        percentage = max(percentage, 0)

        switch side {
        case .In:
            return distance > 0.0 ? 1 : percentage
        case .Out:
            return distance < 0.0 ? 1 : percentage
        case .Any:
            return percentage
        }
    }

    func reversePercentage(_ customSide: Side? = nil) -> CGFloat {
        return 1 - percentage(customSide)
    }
}

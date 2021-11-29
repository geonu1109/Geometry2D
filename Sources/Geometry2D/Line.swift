import Foundation

public struct Line {
    public var slope: Double
    
    public var yIntercept: Double
    
    public var xIntercept: Double {
        get {
            return -self.yIntercept / self.slope
        }
        set {
            self.yIntercept = -newValue * self.slope
        }
    }
    
    public init(slope: Double, yIntercept: Double) {
        self.slope = slope
        self.yIntercept = yIntercept
    }
    
    public init(slope: Double, passThrough point: Point) {
        self.slope = slope
        self.yIntercept = point.y - slope * point.x
    }
    
    public init(passThrough point1: Point, and point2: Point) {
        let slope = (point2.y - point1.y) / (point2.x - point1.x)
        let yIntercept = point2.y - slope * point2.x
        self.init(slope: slope, yIntercept: yIntercept)
    }
    
    public func pointAt(x: Double) -> Point {
        let y = self.slope * x + self.yIntercept
        return .init(x: x, y: y)
    }
    
    public func pointAt(y: Double) -> Point {
        let x = (y - self.yIntercept) / self.slope
        return .init(x: x, y: y)
    }
    
    public func intersection(with line: Line) -> Point {
        let x = -(line.yIntercept - self.yIntercept) / (line.slope - self.slope)
        return self.pointAt(x: x)
    }
    
    public func perpendicular(passThrough point: Point) -> Line {
        let slope = -1 / self.slope
        let yIntercept = point.y - slope * point.x
        return .init(slope: slope, yIntercept: yIntercept)
    }
    
    public func relativePosition(of point: Point) -> Vector {
        let perpendicular = self.perpendicular(passThrough: point)
        let footOfPerpendicular = self.intersection(with: perpendicular)
        return .init(initialPoint: footOfPerpendicular, terminalPoint: point)
    }
}

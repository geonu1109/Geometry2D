import Foundation

public enum LineError: Error {
    case hasInfiniteSolutions
}

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
    
    public static let xAxis: Line = .init(slope: 0, yIntercept: 0)
    
    public static let yAxis: Line = .init(slope: .infinity, yIntercept: 0)
    
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
    
    public func pointAt(x: Double) throws -> Point? {
        guard self.slope != .infinity else {
            throw LineError.hasInfiniteSolutions
        }
        let y = self.slope * x + self.yIntercept
        return .init(x: x, y: y)
    }
    
    public func pointAt(y: Double) throws -> Point {
        guard self.slope != .zero else {
            throw LineError.hasInfiniteSolutions
        }
        let x = (y - self.yIntercept) / self.slope
        return .init(x: x, y: y)
    }
    
    public func intersection(with line: Line) throws -> Point? {
        guard self.slope != line.slope else {
            if self.yIntercept == line.yIntercept {
                throw LineError.hasInfiniteSolutions
            } else {
                return nil
            }
        }
        let x = -(line.yIntercept - self.yIntercept) / (line.slope - self.slope)
        do {
            return try self.pointAt(x: x)
        } catch {
            return try line.pointAt(x: x)
        }
    }
    
    public func perpendicular(passThrough point: Point) -> Line {
        let slope = -1 / self.slope
        let yIntercept = point.y - slope * point.x
        return .init(slope: slope, yIntercept: yIntercept)
    }
    
    public func relativePosition(of point: Point) -> Vector {
        let perpendicular = self.perpendicular(passThrough: point)
        let footOfPerpendicular = try! self.intersection(with: perpendicular)!
        return .init(initialPoint: footOfPerpendicular, terminalPoint: point)
    }
}

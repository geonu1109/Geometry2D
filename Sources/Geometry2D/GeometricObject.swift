import Foundation

public protocol GeometricObject: Equatable {
    var clone: Self { get }
    
    mutating func commit(_ mutation: (inout Vector) -> Void)
}

public extension GeometricObject {
    static var tolerance: Double {
        return .ulpOfOne * 8
    }
    
    mutating func scale(by vector: Vector) {
        self.commit { (point) in
            point.x *= vector.x
            point.y *= vector.y
        }
    }
    
    func scaled(by scalarValue: Double) -> Self {
        var newObject = self.clone
        newObject.scale(by: scalarValue)
        return newObject
    }
    
    mutating func scale(by scalarValue: Double) {
        self.scale(by: .init(x: scalarValue, y: scalarValue))
    }
    
    func scaled(by vector: Vector) -> Self {
        var newObject = self.clone
        newObject.scale(by: vector)
        return newObject
    }
    
    mutating func translate(by vector: Vector) {
        self.commit { (point) in
            point.x += vector.x
            point.y += vector.y
        }
    }
    
    func translated(by vector: Vector) -> Self {
        var newObject = self.clone
        newObject.translate(by: vector)
        return newObject
    }
    
    mutating func range(from minimumPosition: Vector, to maximumPosition: Vector) {
        self.commit { (point) in
            point.x = min(maximumPosition.x, max(minimumPosition.x, point.x))
            point.y = min(maximumPosition.y, max(minimumPosition.y, point.y))
        }
    }
    
    func ranged(from minimumPosition: Vector, to maximumPosition: Vector) -> Self {
        var newObject = self.clone
        newObject.range(from: minimumPosition, to: maximumPosition)
        return newObject
    }
    
    static func * (lhs: Self, rhs: Double) -> Self {
        return lhs.scaled(by: rhs)
    }
    
    static func / (lhs: Self, rhs: Double) -> Self {
        return lhs.scaled(by: 1 / rhs)
    }
}

extension Vector: GeometricObject {
    public static func == (lhs: Vector, rhs: Vector) -> Bool {
        return abs(rhs.x - lhs.x) < self.tolerance && abs(rhs.y - lhs.y) < self.tolerance
    }
    
    public var clone: Vector {
        return self
    }
    
    public mutating func commit(_ mutation: (inout Vector) -> Void) {
        mutation(&self)
    }
}

extension Point: GeometricObject {
    public static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.position == rhs.position
    }
    
    public var clone: Point {
        return self
    }
    
    public mutating func commit(_ mutation: (inout Vector) -> Void) {
        self.position.commit(mutation)
    }
}

extension Square: GeometricObject {
    public static func == (lhs: Square, rhs: Square) -> Bool {
        return lhs.firstVertex == rhs.firstVertex
        && lhs.secondVertex == rhs.secondVertex
        && lhs.thirdVertex == rhs.thirdVertex
        && lhs.fourthVertex == rhs.fourthVertex
    }
    
    public var clone: Square {
        return self
    }
    
    public mutating func commit(_ mutation: (inout Vector) -> Void) {
        self.firstVertex.commit(mutation)
        self.secondVertex.commit(mutation)
        self.thirdVertex.commit(mutation)
        self.fourthVertex.commit(mutation)
    }
}

extension Line: GeometricObject {
    public static func == (lhs: Line, rhs: Line) -> Bool {
        return lhs.slope == rhs.slope && lhs.yIntercept == rhs.yIntercept
    }
    
    public var clone: Line {
        return self
    }
    
    public mutating func commit(_ mutation: (inout Vector) -> Void) {
        var xInterceptPosition: Vector = .init(x: self.xIntercept, y: 0)
        var yInterceptPosition: Vector = .init(x: 0, y: self.yIntercept)
        mutation(&xInterceptPosition)
        mutation(&yInterceptPosition)
        self = .init(passThrough: .init(position: xInterceptPosition), and: .init(position: xInterceptPosition))
    }
    
    public mutating func range(from minimumPosition: Vector, to maximumPosition: Vector) {
        // do nothing
    }
}

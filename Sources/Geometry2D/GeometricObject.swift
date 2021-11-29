import Foundation

public protocol GeometricObject: Equatable {
    var clone: Self { get }
    
    mutating func scale(by vector: Vector)
    
    mutating func translate(by vector: Vector)
    
    mutating func range(from minimumPosition: Vector, to maximumPosition: Vector)
}

public extension GeometricObject {
    static var tolerance: Double {
        return .ulpOfOne * 8
    }
    
    mutating func scale(by scalarValue: Double) {
        self.scale(by: .init(x: scalarValue, y: scalarValue))
    }
    
    func scaled(by scalarValue: Double) -> Self {
        var newObject = self.clone
        newObject.scale(by: scalarValue)
        return newObject
    }
    
    func scaled(by vector: Vector) -> Self {
        var newObject = self.clone
        newObject.scale(by: vector)
        return newObject
    }
    
    func translated(by vector: Vector) -> Self {
        var newObject = self.clone
        newObject.translate(by: vector)
        return newObject
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
    
    public mutating func scale(by vector: Vector) {
        self.x *= vector.x
        self.y *= vector.y
    }
    
    public mutating func translate(by vector: Vector) {
        self.x += vector.x
        self.y += vector.y
    }
    
    public mutating func range(from minimumPosition: Vector, to maximumPosition: Vector) {
        self.x = min(maximumPosition.x, max(minimumPosition.x, self.x))
        self.y = min(maximumPosition.y, max(minimumPosition.y, self.y))
    }
}

extension Point: GeometricObject {
    public static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.position == rhs.position
    }
    
    public var clone: Point {
        return self
    }
    
    public mutating func scale(by vector: Vector) {
        self.position.scale(by: vector)
    }
    
    public mutating func translate(by vector: Vector) {
        self.position.translate(by: vector)
    }
    
    public mutating func range(from minimumPosition: Vector, to maximumPosition: Vector) {
        self.position.range(from: minimumPosition, to: maximumPosition)
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
    
    public mutating func scale(by vector: Vector) {
        self.firstVertex.scale(by: vector)
        self.secondVertex.scale(by: vector)
        self.thirdVertex.scale(by: vector)
        self.fourthVertex.scale(by: vector)
    }
    
    public mutating func translate(by vector: Vector) {
        self.firstVertex.translate(by: vector)
        self.secondVertex.translate(by: vector)
        self.thirdVertex.translate(by: vector)
        self.fourthVertex.translate(by: vector)
    }
    
    public mutating func range(from minimumPosition: Vector, to maximumPosition: Vector) {
        self.firstVertex.range(from: minimumPosition, to: maximumPosition)
        self.secondVertex.range(from: minimumPosition, to: maximumPosition)
        self.thirdVertex.range(from: minimumPosition, to: maximumPosition)
        self.fourthVertex.range(from: minimumPosition, to: maximumPosition)
    }
}

extension Line: GeometricObject {
    public static func == (lhs: Line, rhs: Line) -> Bool {
        return lhs.slope == rhs.slope && lhs.yIntercept == rhs.yIntercept
    }
    
    public var clone: Line {
        return self
    }
    
    public func scale(by vector: Vector) {
        // do nothing
    }
    
    public mutating func translate(by vector: Vector) {
        self.yIntercept += vector.y - self.slope * vector.x
    }
    
    public mutating func range(from minimumPosition: Vector, to maximumPosition: Vector) {
        // do nothing
    }
    
}

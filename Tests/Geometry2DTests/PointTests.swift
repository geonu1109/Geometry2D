import XCTest
import Angle
@testable import Geometry2D

final class PointTests: XCTestCase {
    func testInit() {
        let point1: Point = .init(x: 4, y: 3)
        let point2: Point = .init(r: 5, theta: .radian(.arctangent(of: 3.0 / 4.0)))
        
        XCTAssertEqual(point1, point2)
    }
    
    func testDistance() {
        let point1: Point = .init(x: 0, y: 3)
        let point2: Point = .init(x: 0, y: 6)
        
        XCTAssertEqual(point1.distance(to: point2), 3)
    }
}

import XCTest
import Angle
@testable import Geometry2D

final class VectorTests: XCTestCase {
    func testInit() {
        let vector1: Vector = .init(x: 4, y: 3)
        let vector2: Vector = .init(magnitude: 5, direction: .radian(.arctangent(of: 3.0 / 4.0)))
        
        XCTAssertEqual(vector1, vector2)
    }
    
    func testMagnitude() {
        let vector: Vector = .init(x: 3, y: 4)
        
        XCTAssertEqual(vector.magnitude, 5)
    }
}

import XCTest
import Angle
@testable import Geometry2D

final class LineTests: XCTestCase {
    func testReflectOverXAxis() {
        let point: Point = .init(x: 3, y: 4)
        let xAxis: Line = .xAxis
        let expected: Point = .init(x: 3, y: -4)
        
        let actual: Point = point.reflected(over: xAxis)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testReflectOverYAxis() {
        let point: Point = .init(x: 3, y: 4)
        let yAxis: Line = .yAxis
        let expected: Point = .init(x: -3, y: 4)
        
        let actual: Point = point.reflected(over: yAxis)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testReflectOverOrigin() {
        let point: Point = .init(x: 3, y: 4)
        let origin: Point = .origin
        let expected: Point = .init(x: -3, y: -4)
        
        let actual: Point = point.reflected(over: origin)
        
        XCTAssertEqual(expected, actual)
    }
}

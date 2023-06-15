import XCTest
@testable import ProtocolMatcher

// XCTest Documentation
// https://developer.apple.com/documentation/xctest

// Defining Test Cases and Test Methods
// https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods

/// Test protocol
@objc
protocol Foo { }

/// a conforming class
class Bar : Foo {}

final class ProtocolMatcherTests: XCTestCase {

   let classesConforming: [AnyObject.Type] = ProtocolMatcher().getClassesFor(Foo.self) as! [any Foo.Type]

   func testCount() throws {
      XCTAssertEqual(classesConforming.count,1)
   }

   func testName() throws {
      let className = "\(classesConforming[0].description())"
      XCTAssertEqual("ProtocolMatcherTests.Bar", className)
   }

}

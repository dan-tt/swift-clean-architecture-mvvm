import XCTest
@testable import MySwiftUIApp

final class MySwiftUIAppTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(1 + 1, 2)
    }
    
    func testContentViewInitialization() throws {
        let contentView = ContentView()
        XCTAssertNotNil(contentView)
    }
}

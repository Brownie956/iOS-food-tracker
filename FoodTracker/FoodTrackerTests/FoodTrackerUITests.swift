import XCTest

class FoodTrackerUITests: XCTestCase {
    override func setUp() {
        XCUIApplication().activate()
    }

    func test_adding_a_meal() {
        XCUIApplication().tableRows["chicken-cell"].tap()
        
    }
}

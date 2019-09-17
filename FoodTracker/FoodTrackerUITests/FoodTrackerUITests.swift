import XCTest

class FoodTrackerUITests: XCTestCase {
    override func setUp() {
        XCUIApplication().launch()
    }

    func test_update_a_meal_name() {
        let app = XCUIApplication()
        app.cells["chicken-cell"].staticTexts["Chicken"].tap()
        app.textFields["meal-name-input"].tap()
        app.textFields["meal-name-input"].typeText("Sausage")
        XCUIApplication().keyboards.buttons["Done"].tap()

        app.buttons["save-meal"].tap()

        XCTAssertTrue(app.staticTexts["Sausage"].exists, "sausage-cell not found")
        XCTAssertFalse(app.staticTexts["Chicken"].exists, "chicken-cell found")
    }

    func test_adding_a_meal() {
        let app = XCUIApplication()
        let cakeName = "Cake\(Int.random(in: 0...10000))"

        app.buttons["Add"].tap()
        app.textFields["Enter meal name"].tap()
        app.textFields["Enter meal name"].typeText(cakeName)
        app.keyboards.buttons["Done"].tap()
        app.buttons["Set 4 star rating"].tap()
        app.buttons["save-meal"].tap()

        XCTAssertTrue(app.staticTexts[cakeName].exists, "\(cakeName) can't be found")

        let firstRatingButton = app.cells["\(cakeName.lowercased())-cell"].buttons.firstMatch
        XCTAssertEqual(firstRatingButton.value as! String, "4 stars set.")
    }
}

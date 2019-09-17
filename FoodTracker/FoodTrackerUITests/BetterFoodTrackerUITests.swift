import XCTest

class BetterFoodTrackerUITests: XCTestCase {
    override func setUp() {
        XCUIApplication().launch()
    }

    func test_update_a_meal_name() {
        let food = "Chicken"
        MealTablePage().food_cell_element(food: food.lowercased()).staticTexts[food].tap()
        AddMealPage().enter_meal_name("Sausage")

        AddMealPage().save_meal_button_element().tap()

        XCTAssertTrue(XCUIApplication().staticTexts["Sausage"].exists, "sausage-cell not found")
        XCTAssertFalse(XCUIApplication().staticTexts["Chicken"].exists, "chicken-cell found")
    }

    func test_adding_a_meal() {
        let cakeName = "Cake\(Int.random(in: 0...10000))"

        MealTablePage().add_button_element().tap()
        AddMealPage().enter_meal_name(cakeName)
        AddMealPage().set_four_stars_button_element().tap()
        AddMealPage().save_meal_button_element().tap()

        XCTAssertTrue(XCUIApplication().staticTexts[cakeName].exists, "\(cakeName) can't be found")

        let firstRatingButton = MealTablePage().food_cell_element(food: cakeName.lowercased()).buttons.firstMatch
        XCTAssertEqual(firstRatingButton.value as! String, "4 stars set.")
    }
}

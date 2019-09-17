import XCTest

class AddMealPage {
    //:- Selectors

    func meal_name_input_element() -> XCUIElement {
        return XCUIApplication().textFields["Enter meal name"]
    }

    func keyboard_done_button_element() -> XCUIElement {
        return XCUIApplication().keyboards.buttons["Done"]
    }

    func save_meal_button_element() -> XCUIElement {
        return XCUIApplication().buttons["save-meal"]
    }

    func set_four_stars_button_element() -> XCUIElement {
        return XCUIApplication().buttons["Set 4 star rating"]
    }

    //:- Actions

    func enter_meal_name(_ name: String) {
        meal_name_input_element().tap()
        meal_name_input_element().typeText(name)
        keyboard_done_button_element().tap()
    }
}

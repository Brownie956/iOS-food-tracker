import XCTest

class MealTablePage {

    //:- Selectors

    func food_cell_element(food: String) -> XCUIElement {
        return XCUIApplication().cells["\(food)-cell"]
    }

    func add_button_element() -> XCUIElement {
        return XCUIApplication().buttons["Add"]
    }

    //:- Actions

}

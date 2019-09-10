//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Chris Brown on 24/07/2019.
//  Copyright © 2019 Chris Brown. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    private var ratingButtons = [UIButton]()

    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var startCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }

    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

    private func setupButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }

        ratingButtons.removeAll()

        let bundle = Bundle(for: type(of: self))
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let blackStar = UIImage(named: "blackStar", in: bundle, compatibleWith: self.traitCollection)
        let yellowStar = UIImage(named: "yellowStar", in: bundle, compatibleWith: self.traitCollection)

        for index in 0..<startCount {
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(yellowStar, for: .selected)
            button.setImage(blackStar, for: .highlighted)
            button.setImage(blackStar, for: [.highlighted, .selected])

            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true

            button.accessibilityLabel = "Set \(index + 1) star rating"

            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)

            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }

    @objc
    func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }

        let selectedRating = index + 1

        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }

    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating

            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset rating to zero."
            } else {
                hintString = nil
            }

            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }

            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}

//
//  Meal.swift
//  FoodManagement2027
//
//  Created by User on 04.11.2026.
//

import UIKit

class Meal {
    // MARK: - Properties
    var name: String
    var image: UIImage?
    var rating: Int
    
    // Thuoc tinh ho tro tuong thich neu dung nameMeal
    var nameMeal: String {
        get { return name }
        set { name = newValue }
    }
    
    // MARK: - Constructor
    init?(name: String, image: UIImage? = nil, rating: Int) {
        // Kiem tra name khac rong
        if name.isEmpty {
            return nil
        }
        if rating < 0 || rating > 5 {
            return nil
        }
        self.name = name
        self.image = image
        self.rating = rating
    }
    
    // Ham khoi tao ho tro tuong thich nameMeal
    convenience init?(nameMeal: String, image: UIImage? = nil, rating: Int) {
        self.init(name: nameMeal, image: image, rating: rating)
    }
}

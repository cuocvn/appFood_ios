//
//  Meal.swift
//  FoodManagement2027
//
//  Created by  User on 04.11.2026.
//

import UIKit

class Meal {
    //MARK: properties
    var nameMeal : String
    var image : UIImage?
    var rating : Int
    
    //MARK: contructor
    init?(nameMeal: String, image: UIImage? = nil, rating: Int) {
        //kiem tra name khac rong
        if nameMeal.isEmpty {
            return nil
        }
        if rating < 0 || rating > 5 {
            return nil
        }
        self.nameMeal = nameMeal
        self.image = image
        self.rating = rating
    }
    
    
}

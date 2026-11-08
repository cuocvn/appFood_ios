//
//  MealListController.swift
//  FoodManagement2027
//
//  Created by  User on 04.11.2026.
//

import UIKit

class MealListController: UIViewController {
    //MARK:  Properties
    //Datasource cho table view
    private var mealList = [Meal]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // them du lieu gia cho datasource
        if let meal = Meal(nameMeal: "Ca Ran", image: UIImage(named: "defaut") ,rating: 4)
        {
            mealList.append(meal)
        }
    }
    

}

//
//  MealListController.swift
//  FoodManagement2027
//
//  Created by User on 04.11.2026.
//

import UIKit

class MealListController: UIViewController {
    // MARK: - Properties
    // Datasource cho table view
    private var mealList = [Meal]()
    private let reuseCell = "myTableView"
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. Them du lieu mau cho datasource
        if let meal1 = Meal(nameMeal: "Ca Ran", image: UIImage(named: "default"), rating: 3) {
            mealList.append(meal1)
        }
        
        
        
        // 2. Dang ky myCell (xib) cho doi tuong table view
        let cellNib = UINib(nibName: "myCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: reuseCell)
        
        // 3. Thuc hien uy quyen cho doi tuong table view
        tableView.delegate = self
        tableView.dataSource = self
        
        // 4. Thiet lap chieu cao cho moi dong
        tableView.rowHeight = 90
        
        // Them button edit bang code cho navigation bar
        if let navigationItem = navigationBar?.topItem {
            // Dua editButtonItem vao navigationItem ben trai
            navigationItem.leftBarButtonItem = editButtonItem
        }
    }
}

// MARK: - Cac ham uy quyen cua Table View (UITableViewDelegate, UITableViewDataSource)
extension MealListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? myCell {
            // Lay du lieu can do vao tableview tu datasource
            let meal = mealList[indexPath.row]
            cell.mealImage.image = meal.image
            cell.mealName.text = meal.nameMeal
            cell.mealRating.rating = meal.rating
            
            return cell
        } else {
            // Tra ve cell rong neu khong ep kieu duoc
            return UITableViewCell()
        }
    }
}

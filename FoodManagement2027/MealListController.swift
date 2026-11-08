//
//  MealListController.swift
//  FoodManagement2027
//
//  Created by User on 04.11.2026.
//

import UIKit

class MealListController: UIViewController {
    // MARK: - Properties
    // Datasource cho Table View
    private var mealList = [Meal]()
    private let reuseCell = "myTableCell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. Them du lieu mau cho datasource
        if let meal1 = Meal(name: "Ca ran", image: UIImage(named: "default"), rating: 4) {
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
        // Lay navigationItem trong navigationbar
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
    
    // Ham do du lieu cho tung phan tu cua TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "myTableCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell) as? MyCell {
            // Lay du lieu can do vao tableView tu datasource
            let meal = mealList[indexPath.row]
            // Do du lieu vao cell
            cell.mealImage.image = meal.image
            cell.mealName.text = meal.name
            cell.mealRating.rating = meal.rating
            
            return cell
        }
        else {
            // Tra ve cell rong
            return UITableViewCell()
        }
    }
    
    // Dinh nghia lai ham setEditing
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        // Chuyen chuc nang cho tableView
        tableView.setEditing(editing, animated: animated)
    }
    
    // Dinh nghia lai ham xoa phan tu cua tableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Xoa du lieu trong datasource
            mealList.remove(at: indexPath.row)
            // Xoa phan tu tu tableView
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: Quay ve tu man hinh DetailController
    @IBAction func unwindFromDetailController(segue: UIStoryboardSegue) {
        print("Quay ve tu DetailController")
    }
}

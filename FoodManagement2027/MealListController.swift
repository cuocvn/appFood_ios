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
    
    // MARK: - 1 + 2 + 3. Xu ly khi nguoi dung chon mot dong de xem hoac sua mon an
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1. Lay meal tu vi tri chon
        let meal = mealList[indexPath.row]
        
        // 2 + 3. Khoi tao man hinh Detail va chuyen sang man hinh Detail
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "MealDetailController") as? MealDetailController {
            detailVC.modalPresentationStyle = .fullScreen
            
            // 2. Truyen meal sang man hinh Detail
            detailVC.meal = meal
            
            // 5 + 6. Nhan meal da sua ve va cap nhat lai cho mh List
            detailVC.getBackData = { [weak self] (updatedMeal: Meal) in
                guard let self = self else { return }
                // 6. Cap nhat meal moi cho mh list
                self.mealList[indexPath.row] = updatedMeal
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
            
            // 3. Chuyen man hinh sang detail
            present(detailVC, animated: true)
        }
    }
    
    // MARK: Quay ve tu man hinh DetailController (Unwind Segue)
    @IBAction func unwindFromDetailController(segue: UIStoryboardSegue) {
        //print("Quay ve tu DetailController")
        // 3. Cap nhat mon an tu man hinh meal detail ve
        // Lay toan bo man hinh mealdetail va lay gia tri meal vua tao
        if let mealDetailController = segue.source as? MealDetailController, let meal = mealDetailController.meal {
            // Kiem tra xem co phai chon dong de sua hay them moi
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // 5 + 6. Cap nhat meal da sua cho man hinh list
                mealList[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .fade)
            } else {
                // Cap nhat vao TableView (them moi)
                // 3.1 Tim vi tri de chen mon an moi trong TableView
                let newIndexPath = IndexPath(row: mealList.count, section: 0)
                // 3.2 Dua mon an moi vao mealList
                mealList.append(meal)
                // 3.3 Cap nhat len tableView
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        }
    }
    
    // Xu ly truoc khi chuyen man hinh (danh cho Segue them moi / sua)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Xu ly callback tu man hinh B
        if let detailController = segue.destination as? MealDetailController {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // 1. Lay meal tu vi tri chon
                let selectedMeal = mealList[selectedIndexPath.row]
                // 2. Truyen meal sang man hinh Detail
                detailController.meal = selectedMeal
                
                // 5 + 6. Cap nhat mon an da sua cho mh list
                detailController.getBackData = { [weak self] (meal: Meal) in
                    guard let self = self else { return }
                    self.mealList[selectedIndexPath.row] = meal
                    self.tableView.reloadRows(at: [selectedIndexPath], with: .fade)
                }
            } else {
                // Truong hop them moi (nhan nut +)
                detailController.getBackData = { [weak self] (meal: Meal) in
                    guard let self = self else { return }
                    // Cap nhat vao TableView
                    // 3.1 Tim vi tri de chen mon an moi trong TableView
                    let newIndexPath = IndexPath(row: self.mealList.count, section: 0)
                    // 3.2 Dua mon an moi vao mealList
                    self.mealList.append(meal)
                    // 3.3 Cap nhat len tableView
                    self.tableView.insertRows(at: [newIndexPath], with: .fade)
                }
            }
        }
    }
}

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
    @IBAction func unWindFromDetailController(segue: UIStoryboardSegue) {
        //print("Quay ve tu DetailController")
        // 3. Cap nhat mon an tu man hinh meal detail ve
        // Lay toan bo man hinh mealdetail va lay gia tri meal vua tao
        if let mealDetailController = segue.source as? MealDetailController, let meal = mealDetailController.meal {
            // Cap nhat vao TableView
            // 3.1 Tim vi tri de chen mon an moi trong TableView
            let newIndexPath = IndexPath(row: mealList.count, section: 0)
            // 3.2 Dua mon an moi vao mealList
            mealList.append(meal)
            // 3.3 Cap nhat len tableView
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    @IBAction func unwindFromDetailController(segue: UIStoryboardSegue) {
        unWindFromDetailController(segue: segue)
    }
    
    // Xu ly truoc khi chuyen man hinh
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Xu ly callBack tu man hinh B
        if let detailController = segue.destination as? MealDetailController {
            detailController.getBackData = { (meal:Meal) in
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
    
    // Xu ly chuyen man hinh khi edit mon an
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Ban vua chon mon an thu: \(indexPath.row)")
        // Bo chon moi khi select row
        tableView.deselectRow(at: indexPath, animated: true)
        // 1. Lay bien meal trong row duoc chon
        let meal = mealList[indexPath.row]
        // 2.1 Tao man hinh Detail bang cong cu storyboard
        if let mealDetail = self.storyboard?.instantiateViewController(withIdentifier: "MealDetailID") as? MealDetailController{
            //2.2 Truyen tham so meal cho man hinh detail
            mealDetail.meal = meal
            
            // 2.3 Lay du lieu ve tu Detail
            mealDetail.getBackData = { (meal:Meal) in
                // 6. Cap nhat lai row
                // Dua meal moi vao datgsource
                self.mealList[indexPath.row] = meal
                // Cap nhat lai tren tableview
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
            
            // 3. Chuyen man hinh sang Meal Detail Controller
            mealDetail.modalPresentationStyle = .fullScreen
            present(mealDetail, animated: true)
        }
    }
}

//
//  MealListController.swift
//  FoodManagement2027
//
//  Created by User on 04.11.2026.
//

import UIKit

class MealListController: UIViewController {

    // MARK: - UI Components / Outlets
    /// Navigation Bar ở trên cùng chứa tiêu đề "List of Meals" và Bar Button "Add"
    @IBOutlet weak var navigationBar: UINavigationBar!

    /// View Container ở phía trên màn hình (cách trên 20px, ngang 10 và 10)
    @IBOutlet weak var containerView: UIView!

    /// Table View hiển thị danh sách món ăn (cách view trên 10, 2 bên và dưới 10)
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup UI & Auto Layout
    private func setupUI() {
        view.backgroundColor = .systemBackground
        let safeArea = view.safeAreaLayoutGuide

        // 1. Navigation Bar (khởi tạo bằng code nếu chưa có từ Storyboard)
        if navigationBar == nil {
            let navBar = UINavigationBar()
            navBar.translatesAutoresizingMaskIntoConstraints = false
            let navItem = UINavigationItem(title: "List of Meals")
            let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(btnAddTapped))
            navItem.rightBarButtonItem = addBtn
            navBar.setItems([navItem], animated: false)
            view.addSubview(navBar)
            self.navigationBar = navBar

            NSLayoutConstraint.activate([
                navBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
                navBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                navBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
        }

        // 2. View Container
        if containerView == nil {
            let container = UIView()
            container.backgroundColor = .systemGray5
            container.layer.cornerRadius = 8
            container.clipsToBounds = true
            container.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(container)
            self.containerView = container

            let topAnchorSource = navigationBar?.bottomAnchor ?? safeArea.topAnchor
            NSLayoutConstraint.activate([
                // Cách mép trên (Top) 20px
                container.topAnchor.constraint(equalTo: topAnchorSource, constant: 20),
                // Cách mép trái (Leading) 10px
                container.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
                // Cách mép phải (Trailing) 10px (-10)
                container.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
                // Chiều cao container
                container.heightAnchor.constraint(equalToConstant: 50)
            ])
        }

        // 3. Table View
        if tableView == nil {
            let table = UITableView()
            table.backgroundColor = .clear
            table.layer.cornerRadius = 8
            table.clipsToBounds = true
            table.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(table)
            self.tableView = table

            NSLayoutConstraint.activate([
                // Cách mép dưới của containerView đúng 10px
                table.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
                // 2 bên (Leading/Trailing) cách 10px
                table.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
                table.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
                // Dưới (Bottom) cách 10px (-10)
                table.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10)
            ])
        }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MealCell")
    }

    // MARK: - Actions
    @IBAction @objc func btnAddTapped(_ sender: Any) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "MealDetailController") as? MealDetailController {
            detailVC.modalPresentationStyle = .fullScreen
            present(detailVC, animated: true)
        } else {
            performSegue(withIdentifier: "showNewMeal", sender: self)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MealListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath)
        return cell
    }
}

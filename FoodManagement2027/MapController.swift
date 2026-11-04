//
//  MapController.swift
//  FoodManagement2027
//
//  Created by User on 04.11.2026.
//

import UIKit
import MapKit

class MapController: UIViewController {

    // MARK: - UI Components / Outlets
    /// Navigation Bar ở trên cùng ghi "Map Screen" có nút Back bên trái
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var mapView: MKMapView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        let safeArea = view.safeAreaLayoutGuide

        // 1. Navigation Bar (khởi tạo bằng code nếu chưa có từ Storyboard)
        if navigationBar == nil {
            let navBar = UINavigationBar()
            navBar.translatesAutoresizingMaskIntoConstraints = false
            let navItem = UINavigationItem(title: "Map Screen")
            let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(btnBackTapped))
            navItem.leftBarButtonItem = backButton
            navBar.setItems([navItem], animated: false)
            view.addSubview(navBar)
            self.navigationBar = navBar

            NSLayoutConstraint.activate([
                navBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
                navBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                navBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
        }

        // 2. MapView
        if mapView == nil {
            let map = MKMapView()
            map.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(map)
            self.mapView = map

            let topAnchorSource = navigationBar?.bottomAnchor ?? safeArea.topAnchor
            NSLayoutConstraint.activate([
                map.topAnchor.constraint(equalTo: topAnchorSource),
                map.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                map.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                map.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            ])
        }
    }

    // MARK: - Actions
    @IBAction @objc func btnBackTapped(_ sender: Any) {
        // Quay về màn hình trước đó
        if let navController = navigationController {
            navController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}

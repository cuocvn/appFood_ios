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
    @IBOutlet weak var mapView: MKMapView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
    }

    // MARK: - Navigation Setup
    private func setupNavigation() {
        // Tiêu đề của Navigation Bar: Map Screen
        navigationItem.title = "Map Screen"

        // Nút Back ở góc bên trái
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(btnBackTapped))
        navigationItem.leftBarButtonItem = backButton
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground

        // Khởi tạo MapView bằng code nếu chưa được gán từ Storyboard
        if mapView == nil {
            let map = MKMapView()
            map.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(map)
            self.mapView = map

            let safeArea = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                map.topAnchor.constraint(equalTo: safeArea.topAnchor),
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

//
//  ViewController.swift
//  FoodManagement2027
//
//  Created by  User on 28.10.2026.
//

import UIKit

//B1. Xac dinh Protocal chua ham uy quyen cho TextField => UITextFieldDelegate
class MealDetailController: UIViewController, UITextFieldDelegate {
    //MARK: Properties
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var Imager: UIImageView!
    @IBOutlet weak var edtMealName: UITextField!
    @IBOutlet weak var btnGoToMap: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar ghi "NewMeal"
        if let navBar = navigationBar, navBar.items?.first == nil {
            let navItem = UINavigationItem(title: "NewMeal")
            navBar.setItems([navItem], animated: false)
        }
        
        //B3. Thuc hien ham uy quyen cho doi tuong TextField
        edtMealName?.delegate = self
    }

    //MARK: Dinh nghia cac ham uy quyen cho doi tuong TextField
    //B2. Dinh nghia ham uy quyen
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        edtMealName?.resignFirstResponder()
        return true
    }
    
    //Ham lay du lieu ra khoi textField
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            print("ten mon an la: \(text)")
        }
    }
    
    //MARK: Ham Xu Li Chon Anh Tu Thu Vien Anh
    @IBAction func imagePicker(_ sender: UITapGestureRecognizer) {
        edtMealName?.resignFirstResponder()
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true)
    }

    // MARK: - Chuyen sang Map Screen
    @IBAction func btnGoToMapTapped(_ sender: UIButton) {
        if let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapController") as? MapController {
            mapVC.modalPresentationStyle = .fullScreen
            present(mapVC, animated: true)
        } else {
            performSegue(withIdentifier: "showMap", sender: self)
        }
    }
}

//MARK: mo rong cho cac hm uy quyen cua UIImagePickerController
extension MealDetailController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage], let image = selectedImage as? UIImage {
            Imager?.image = image
        }
        dismiss(animated: true)
    }
}

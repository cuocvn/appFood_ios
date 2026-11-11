//
//  ViewController.swift
//  FoodManagement2027
//
//  Created by User on 28.10.2026.
//

import UIKit

// B1. Xac dinh Protocol chua ham uy quyen cho TextField => UITextFieldDelegate
class MealDetailController: UIViewController, UITextFieldDelegate {
    // MARK: Properties
    @IBOutlet weak var edtMealName: UITextField!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealRating: UIRating!
    
    // Thuoc tinh tuong thich neu dung Imager
    var Imager: UIImageView! {
        get { return mealImage }
        set { mealImage = newValue }
    }
    
    // Bien dung de truyen tham so meal giua man hinh A va B
    var meal: Meal?
    
    // Dinh nghia callback quay ve man hinh A
    var getBackData: ((_ meal: Meal) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // B3. Thuc hien ham uy quyen cho doi tuong TextField
        edtMealName.delegate = self
    }

    // MARK: Dinh nghia cac ham uy quyen cho doi tuong TextField
    // B2. Dinh nghia ham uy quyen
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print("Called")
        
        // An ban phim dien thoai
        edtMealName.resignFirstResponder()
        return true
    }
    
    // Ham lay du lieu ra khoi textField
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Ten mon an la: \(textField.text!)")
    }
    
    // MARK: Ham xu ly chon anh tu thu vien anh
    @IBAction func imagePicker(_ sender: UITapGestureRecognizer) {
        //print("Called")
        // An ban phim (Neu co)
        edtMealName.resignFirstResponder()
        // Tao doi tuong UIImagePickerController
        let imagePicker = UIImagePickerController()
        // Cau hinh cho doi tuong imagePicker
        imagePicker.sourceType = .photoLibrary
        
        // Thuc hien thao tac uy quyen cho doi tuong imagePicker
        imagePicker.delegate = self
        
        // Cau hinh cho imagePicker hien thi full Screen
        imagePicker.modalPresentationStyle = .fullScreen
        
        // Chuyen dieu khien sang man hinh cua imagePicker
        present(imagePicker, animated: true)
    }
    
    // MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // An man hinh hien tai
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1. Tao mon an tu thong tin nguoi dung nhap vao
        let name = edtMealName.text ?? ""
        let meal = Meal(name: name, image: mealImage.image, rating: mealRating.rating)
        // 2. Dua doi tuong meal vua tao vao bien thanh phan de truyen di
        self.meal = meal
        
        // Goi callback neu co
        if let meal = meal {
            getBackData?(meal)
        }
    }
}

// MARK: Mo rong cho cac ham uy quyen cua UIImagePickerController
extension MealDetailController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Anh man hinh hien tai => Quay ve man hinh truoc
        dismiss(animated: true)
    }
    
    // Ham xu ly anh lay ve tu imagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Xu ly anh chon duoc
        if let selectedImage = info[.originalImage], let image = selectedImage as? UIImage {
            mealImage.image = image
        }
        // Anh man hinh hien tai => Quay ve man hinh truoc do
        dismiss(animated: true)
    }
}

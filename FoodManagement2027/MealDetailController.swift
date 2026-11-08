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
    @IBOutlet weak var Imager: UIImageView!
    @IBOutlet weak var edtMealName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //B3. Thuc hien ham uy quyen cho doi tuong TextField
        edtMealName.delegate = self
    }

    //MARK: Dinh nghia cac ham uy quyen cho doi tuong TextField
    //B2. Dinh nghia ham uy quyen
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print("Called")
        edtMealName.resignFirstResponder()
        return true
    }
    
    
    //Ham lay du lieu ra khoi textField
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("ten mon an la: \(textField.text!)")
    }
    
    //MARK: Ham Xu Li Chon Anh Tu Thu Vien Anh
    
    @IBAction func imagePicker(_ sender: UITapGestureRecognizer) {
        //print("called")
        //An ban phim neu co
        edtMealName.resignFirstResponder()
        //Tao doi tuong UIImagePickerController
        let imagePicker = UIImagePickerController()
        //Cau hinh cho doi tuong imagePicker
        imagePicker.sourceType = .photoLibrary
        
        //thuc hien thao tac uy quyen cho doi tuong imagePicker
        imagePicker.delegate = self
        
        //cau hinh cho imagepicker hien thi full screen
        imagePicker.modalPresentationStyle = .fullScreen
        
        // Chuyen dieu khien sang man hinh imagePicker
        present(imagePicker, animated: true)
    }
    
    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
//MARK: mo rong cho cac hm uy quyen cua UIImagePickerController
extension MealDetailController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //an man hinh hien tai => quay ve man hinh truoc
        dismiss(animated: true)
    }
    // ham xu ly anh lay ve tu inmagepicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // xy ly anh chon duoc
        if  let selectedImage = info[.originalImage], let image = selectedImage as? UIImage{
            Imager.image = image
        }
        
        // anh man hinh hien tai => quay ve man hinh trc do
        dismiss(animated: true)
    }
}

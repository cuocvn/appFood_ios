//
//  UIRating.swift
//  FoodManagement2027
//
//  Created by  User on 01.11.2026.
//

import UIKit

class UIRating: UIStackView {
    //mark:diinh nghia cac bien thanh phan cua UIRATING
    var rating = 0 {
        didSet {
            updateRatingButton()
        }
    }
    private var ratingButtons = [UIButton]()
    @IBInspectable private var starNum: Int = 5{
        didSet {
            settupUIRating()
        }
    }
    @IBInspectable private var starSize: CGSize = CGSize(width: 44, height: 44){
        didSet {
            settupUIRating()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Goi phuong thuc xay dung doi tuong UIRating
        settupUIRating()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        // Goi phuong thuc xay dung doi tuong UIRating
        settupUIRating()
    }
    
    // MARK: Phuong thuc xay dung doi tuong UIRating
    private func settupUIRating() {
        //xoa cac btn cu truoc khi tao moi
        for btn in ratingButtons {
            //xoa cac rang buoc giua stackView va cac btn con
            removeArrangedSubview(btn)
            btn.removeFromSuperview()
        }
        
        //xoa than chieu trong mang
        ratingButtons.removeAll()
        
        // Xay dung cac Button cua doi tuong UIRating
        // Load anh stars tu Assets
        let normal = UIImage(named: "normal")
        let pressed = UIImage(named: "pressed")
        let selected = UIImage(named: "selected")
        
        for _ in 0..<5 {
            let btnRating = UIButton()
            // Cau hinh cho btnRating
            btnRating.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
            btnRating.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            // Thiet lap mau nen ban dau
            //btnRating.backgroundColor = UIColor.red
            btnRating.setImage(normal, for: .normal)
            btnRating.setImage(pressed, for: .highlighted)
            btnRating.setImage(selected, for: .selected)
            btnRating.setImage(pressed, for: [.selected, .highlighted])
            
            // Cau hinh cho doi tuong UIRating
            spacing = 8
            alignment = .fill
            distribution = .fillEqually
            //bat su kien cho cac doi tuong btnRatting
            btnRating.addAction(UIAction(handler: {action in
                
                //lay tham chieu dnedoi tuong buton duoc nguo dung tap vao
                if let buttonTaped = action.sender as? UIButton{
                    //tim vi tri cua buttontaped trong mang
                    let index = self.ratingButtons.firstIndex(of: buttonTaped)
                    //cap nhat lai gia tri rating cua uirating
                    self.rating = (index! + 1) == self.rating ? index! : index! + 1                    	//cap nhat gia tri ratting cua UIrating
                    print("vi tri cua button dc nhan la :\(self.rating)")
                }
            }), for:.touchUpInside)
            
            //them btnrating vao mang de quan ly
            ratingButtons.append(btnRating)
            // Gan doi tuong btnRating vua tao voi lop cha UIRating
            addArrangedSubview(btnRating)
        }
    }
    //mark ham cap nhat trang thai chonj cua UIrating
    private func updateRatingButton(){
        for (index, btn) in ratingButtons.enumerated() {
            btn.isSelected = index < self.rating
            
        }
            
        
    }
    
}

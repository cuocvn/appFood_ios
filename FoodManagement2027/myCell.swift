//
//  myCell.swift
//  FoodManagement2027
//
//  Created by  User on 04.11.2026.
//

import UIKit

class myCell: UITableViewCell {

    @IBOutlet weak var mealRating: UIRating!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  CategoryCell.swift
//  jsonCategorySubcategory
//
//  Created by Akash Technolabs on 23/02/18.
//  Copyright © 2018 Akash Technolabs. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    
    @IBOutlet var ivCateImage: UIImageView!
    @IBOutlet var lblCateTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

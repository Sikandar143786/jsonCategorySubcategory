//
//  SubCategoryCell.swift
//  jsonCategorySubcategory
//
//  Created by Akash Technolabs on 23/02/18.
//  Copyright © 2018 Akash Technolabs. All rights reserved.
//

import UIKit

class SubCategoryCell: UITableViewCell {

    @IBOutlet var ivSubCateImage: UIImageView!
    @IBOutlet var lblSubCatTitle: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

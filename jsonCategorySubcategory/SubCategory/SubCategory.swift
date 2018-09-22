//
//  SubCategory.swift
//  jsonCategorySubcategory
//
//  Created by Akash Technolabs on 23/02/18.
//  Copyright © 2018 Akash Technolabs. All rights reserved.
//

import UIKit

class SubCategory: UIViewController , UITableViewDelegate, UITableViewDataSource{

    var cat_id = String()
    @IBOutlet var tvSubCategory: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvSubCategory.delegate = self
        tvSubCategory.dataSource = self
        
        fetch_sub_category_details()
    }

    
    @IBAction func btnBackAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 59
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JSONField.arr_sub_cat_title.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCatCell")as! SubCategoryCell
        cell.lblSubCatTitle.text = JSONField.arr_sub_cat_title[indexPath.row]
        
        //displya the image
        if let imageURL = URL(string: JSONField.arr_sub_cat_image[indexPath.row])
        {
            print(imageURL)
            DispatchQueue.global().async
                {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data
                    {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.ivSubCateImage.image = image
                        }
                    }
            }
        }
        
        return cell
    }
    

    func fetch_sub_category_details()
    {
        
        let url = URL(string:WEB_URL.SUB_CATEGORY_URL + cat_id)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            if let arrayJson = adata["subcategory"] as? NSArray
            {
                //when you again request for sub catefory the id will be clear for new request
                JSONField.arr_sub_cat_id.removeAll()
                JSONField.arr_sub_cat_title.removeAll()
                JSONField.arr_sub_cat_image.removeAll()
                
                for index in 0...(adata["subcategory"]?.count)! - 1{
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let sub_cat_IdJson = (object["sub_category_id"]as! String)
                    JSONField.arr_sub_cat_id.append(sub_cat_IdJson)
                    
                    let sub_cat_titleJson = (object["sub_category_name"]as! String)
                    JSONField.arr_sub_cat_title.append(sub_cat_titleJson)
                    
                    let sub_cat_imageJson = (object["sub_category_image"]as! String)
                    JSONField.arr_sub_cat_image.append(sub_cat_imageJson)
                }
            }
        }
        catch{print("error:\(error)")
        }
    }
   
}

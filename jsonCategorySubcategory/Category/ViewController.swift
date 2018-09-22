//
//  ViewController.swift
//  jsonCategorySubcategory
//
//  Created by Akash Technolabs on 23/02/18.
//  Copyright © 2018 Akash Technolabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tvCategory: UITableView!
    var selected_cat_id = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvCategory.delegate = self
        tvCategory.dataSource = self
        
        fetch_categories_details()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 59
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JSONField.arr_cat_name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")as! CategoryCell
        cell.lblCateTitle.text = JSONField.arr_cat_name[indexPath.row]
        
        //displya the image
        if let imageURL = URL(string: JSONField.arr_cat_image[indexPath.row])
        {
            print(imageURL)
            DispatchQueue.global().async
                {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data
                    {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.ivCateImage.image = image
                        }
                    }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tvCategory.deselectRow(at: indexPath, animated: true)
        let subCate = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCategory")as! SubCategory
        selected_cat_id = JSONField.arr_cat_id[indexPath.row]
        subCate.cat_id = selected_cat_id
        navigationController?.pushViewController(subCate, animated: true)
    }
    
    //for the fetch the category details
    func fetch_categories_details()
    {
        //url for get category detaills
        let url = URL(string:WEB_URL.CATEGORIES_URL)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            if let arrayJson = adata["category"] as? NSArray
            {
                for index in 0...(adata["category"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    //storing reference data
                    let catIdJson = (object["category_id"]as! String)
                    JSONField.arr_cat_id.append(catIdJson)
                    
                    let catNameJson = (object["category_name"]as! String)
                    JSONField.arr_cat_name.append(catNameJson)
                    
                    let catImageJson = (object["category_image"]as! String)
                    JSONField.arr_cat_image.append(catImageJson)
                }
            }
        }
        catch
        {print("error=\(error)")
        }
    }
}


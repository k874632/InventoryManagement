//
//  Inventory.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/3/2.
//  Copyright © 2018年 Nick. All rights reserved.

import UIKit
import Firebase

@available(iOS 11.0, *)
class Inventory: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating {
    
    @IBOutlet var inventoryTableView: UITableView!
    
    let uid = Auth.auth().currentUser!.uid
    
    var inventoryNames = [String]()
    var filteredData = [String]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if navigationItem.searchController?.isActive == true {
            return filteredData.count
        } else {
            return inventoryNames.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = inventoryTableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath)
        
        if navigationItem.searchController?.isActive == true {
            cell.textLabel?.text = filteredData[indexPath.row]
        } else {
            cell.textLabel?.text = inventoryNames[indexPath.row]
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        print(indexPath.row)
        print(inventoryNames[row])
        
        
        
//        proVC.inventoryNames.text = inventoryNames[row]
//        self.navigationController?.popViewController(animated: true)
        
    }
    
    var refData: DatabaseReference! //這是google定義的類別
    var RefHandle: DatabaseHandle?

    func observe(){  //觀察refClass，『.childAdded』是當它新增時動作，snapshot(是自取的名字)
        RefHandle = refData.observe(.childAdded, with: { (snapshot) in
            //Dictionary是<key,Value>的版型，將snapshot強制轉型後取裡面的值
            let datas = snapshot.value as! Dictionary<String, AnyObject>
            for (_,value) in datas{  //將datas的資料傳過來，並取裡面的(key,value)
                //因為Dictionary的是value是AnyObject，所以要強制轉型成String
                let aStr = value as! String
                self.inventoryNames.append(aStr)
            }

            //tableView重新載入資料
            self.inventoryTableView.reloadData()
            print("datas=\(datas)")
            print("snapshot=\(snapshot)")
        })
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchString = searchController.searchBar.text!
        filteredData = inventoryNames.filter{ (inventoryNames: String) -> Bool in
                return inventoryNames.contains(searchString)
        }
        inventoryTableView.reloadData()
        
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //到firebase取Classification的路徑
        refData = Database.database().reference().child("UserUid-\(uid)/ProductNames")
        print("refData=\(refData)")

        observe()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false //true的話，點search時，tableView會變暗
        navigationItem.searchController = searchController
        definesPresentationContext = true //false的話，點search時search bar也會變暗
        navigationItem.hidesSearchBarWhenScrolling = true  //true時，隱藏search，table下拉才出現
        
    }

}

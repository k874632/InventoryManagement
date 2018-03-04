//
//  Inventory.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/3/2.
//  Copyright © 2018年 Nick. All rights reserved.

import UIKit
import Firebase

class Inventory1: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchResultsUpdating {
    
    @IBOutlet var inventoryTableView: UITableView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    let uid = Auth.auth().currentUser!.uid
    var inventoryNames = ["123","456","789"]
    var filteredData = [String]()
    
    var searchCotroller = UISearchController()
    var resultsController = UITableViewController()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == inventoryTableView{
            return filteredData.count
        }else{
            return inventoryNames.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if tableView == inventoryTableView{
            cell.textLabel?.text = filteredData[indexPath.row]
        }else{
            cell.textLabel?.text = inventoryNames[indexPath.row]
        }
        
        return cell
        
    }
    
    //    var refData: DatabaseReference! //這是google定義的類別
    //    var RefHandle: DatabaseHandle?
    //
    //    func observe(){  //觀察refClass，『.childAdded』是當它新增時動作，snapshot(是自取的名字)
    //        RefHandle = refData.observe(.childAdded, with: { (snapshot) in
    //            //Dictionary是<key,Value>的版型，將snapshot強制轉型後取裡面的值
    //            let datas = snapshot.value as! Dictionary<String, AnyObject>
    //            for (_,value) in datas{  //將datas的資料傳過來，並取裡面的(key,value)
    //                //因為Dictionary的是value是AnyObject，所以要強制轉型成String
    //                let aStr = value as! String
    //                self.inventoryNames.append(aStr)
    //            }
    //
    //            //tableView重新載入資料
    //            self.inventoryTableView.reloadData()
    //            print("datas=\(datas)")
    //            print("snapshot=\(snapshot)")
    //        })
    //    }
    
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {              //1
    //        if searchBar.text == nil || searchBar.text == ""{
    //            isSearching = false
    //            view.endEditing(true)
    //            inventoryTableView.reloadData()
    //        }else{
    //            isSearching = true
    //            filteredData = inventoryNames.filter({$0 == searchBar.text})
    //            inventoryTableView.reloadData()
    //        }
    //    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredData = inventoryNames.filter({ (inventoryNames: String) -> Bool in
            if inventoryNames.contains(searchController.searchBar.text!){
                return true
            }else{
                return false
            }
        })
        inventoryTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        //到firebase取Classification的路徑
        //        refData = Database.database().reference().child("UserUid-\(uid)/ProductNames")
        //        print("refData=\(refData)")
        //
        //        observe()
        
        
        //
                inventoryTableView.delegate = self      //2
                inventoryTableView.dataSource = self    //2
        
    }
    
}


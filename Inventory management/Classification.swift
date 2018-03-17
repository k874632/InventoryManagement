//
//  Classification.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/2/10.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit
import Firebase


class Classification: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var proVC:NewProduct!
    
    let uid = Auth.auth().currentUser!.uid
    var key = [String]()
    
    @IBOutlet var classTableView: UITableView!
    @IBAction func add(_ sender: UIBarButtonItem) {
        
        let vcCN = self.storyboard?.instantiateViewController(withIdentifier: "ClassName")as! Classname
        
        self.navigationController?.present(vcCN, animated: true, completion: nil)
        
    }
    
    //分類名稱
    var classNames = [String]()
    
    //cell數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classNames.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "ClassCell")
        cell1?.textLabel?.text = classNames[indexPath.row]
        return cell1!
        
    }
    
    
    //點選cell時執行動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
        let row = indexPath.row
        print(classNames[row])
        
        proVC.className.text=classNames[row]
        self.navigationController?.popViewController(animated: true)
        
    }
    
    var refClass: DatabaseReference! //這是google定義的類別
    var RefHandle: DatabaseHandle?
    
    func observe(){  //觀察refClass，『.childAdded』是當它新增時動作，snapshot(是自取的名字)
        RefHandle = refClass.observe(.childAdded, with: { (snapshot) in
            //Dictionary是<key,Value>的版型，將snapshot強制轉型後取裡面的值
            let datas = snapshot.value as! Dictionary<String, AnyObject>
                for (_,value) in datas{  //將datas的資料傳過來，並取裡面的(key,value)
                    //因為Dictionary的是value是AnyObject，所以要強制轉型成String
                    let aStr = value as! String
                    self.classNames.append(aStr)
                    let keyID = snapshot.key
                    self.key.append(keyID)
                }
            
            //tableView重新載入資料
            self.classTableView.reloadData()
        })
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //刪除firebase的資料(cell)
        if editingStyle == .delete{
            
            refClass.database.reference().child("UserUid-\(uid)/Classification/\(key[indexPath.row])").removeValue()
            print("delete _ \(key[indexPath.row])")
            
            self.key.remove(at: indexPath.row)
            self.classNames.remove(at: indexPath.row)
        }
        
        self.classTableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(classNames)
        
        //到firebase取Classification的路徑
        refClass = Database.database().reference().child("UserUid-\(uid)/Classification")
        print("refclass=\(refClass)")
        
        observe()
        
    }
    
    
}


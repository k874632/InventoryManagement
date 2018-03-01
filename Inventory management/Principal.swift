//
//  Principal.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/3/1.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit
import Firebase

class Principal: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var proVC:NewProduct!
    
    let uid = Auth.auth().currentUser!.uid
    
    @IBOutlet var principalTableView: UITableView!
    
    //分類名稱
    var principalNames = ["＋新增負責人"]
    
    //cell數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return principalNames.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0{
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "PrincipalCell")
            cell1?.textLabel?.text = "＋新增負責人"
            return cell1!
        }else{
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "PrincipalCell")
            cell1?.textLabel?.text = principalNames[indexPath.row]
            return cell1!
        }
    }
    
    //點選cell時執行動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
        
        if indexPath.row == 0{
            let vcPL = self.storyboard?.instantiateViewController(withIdentifier: "PrincipalName")as! PrincipalName
            
            self.navigationController?.present(vcPL, animated: true, completion: nil)
            
        }else{
            
            let row = indexPath.row
            print(principalNames[row])
            
            proVC.principal.text = principalNames[row]
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    var refPrincipal: DatabaseReference! //這是google定義的類別
    var RefHandle: DatabaseHandle?
    
    func observe(){  //觀察refClass，『.childAdded』是當它新增時動作，snapshot(是自取的名字)
        RefHandle = refPrincipal.observe(.childAdded, with: { (snapshot) in
            //Dictionary是<key,Value>的版型，將snapshot強制轉型後取裡面的值
            let datas = snapshot.value as! Dictionary<String, AnyObject>
            for (_,value) in datas{  //將datas的資料傳過來，並取裡面的(key,value)
                //因為Dictionary的是value是AnyObject，所以要強制轉型成String
                let aStr = value as! String
                self.principalNames.append(aStr)
            }
            
            //tableView重新載入資料
            self.principalTableView.reloadData()
            print("datas=\(datas)")
            print("snapshot=\(snapshot)")
        })
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //新增刪除語法！
            //            refClass.database.reference().child("UserUid-\(uid)/Classification").removeValue()
            
            refPrincipal.database.reference().child("UserUid-\(uid)/Place").observe(.value, with: { (snapshot) in
                if let result = snapshot.children.allObjects as? [DataSnapshot] {
                    for child in result {
                        let productID = child.key
                        print("productID=\(productID)")
                    }
                }
            })
            
        }
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(principalNames)
        
        //到firebase取Classification的路徑
        refPrincipal = Database.database().reference().child("UserUid-\(uid)/Principal")
        print("refprincipal=\(refPrincipal)")
        
        observe()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

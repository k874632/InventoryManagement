//
//  ProductName.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/3/5.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit
import Firebase

var refProName: DatabaseReference!

class ProductName: UITableViewController {
    var userUid:String = ""
    
    @IBOutlet var productName: UITextField!
    @IBOutlet var className: UILabel!
    @IBOutlet var place: UILabel!
    @IBOutlet var quantity: UILabel!
    @IBOutlet var principal: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var remarks: UITextView!
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //備註的Cell高度設定300，其他高度設定44
        if indexPath.row == 6{
            return 300
        }else{
            return 44
        }
        
    }
    
//    var refClass: DatabaseReference! //這是google定義的類別
//    var RefHandle: DatabaseHandle?
//    
//    func observe(){  //觀察refClass，『.childAdded』是當它新增時動作，snapshot(是自取的名字)
//        RefHandle = refClass.observe(.childAdded, with: { (snapshot) in
//            //Dictionary是<key,Value>的版型，將snapshot強制轉型後取裡面的值
//            let datas = snapshot.value as! Dictionary<String, AnyObject>
//            for (_,value) in datas{  //將datas的資料傳過來，並取裡面的(key,value)
//                //因為Dictionary的是value是AnyObject，所以要強制轉型成String
//                let aStr = value as! String
//                self.classNames.append(aStr)
//            }
//            
//            //tableView重新載入資料
//            self.productName.reloadInputViews()
//            print("datas=\(datas)")
//            print("snapshot=\(snapshot)")
//        })
//    }
    
    //按背景收起鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

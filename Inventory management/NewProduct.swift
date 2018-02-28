//
//  VC1.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/2/3.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit
import Firebase

var refProduct: DatabaseReference!

class NewProduct: UITableViewController {
    var userUid:String = ""
    
    @IBOutlet var productName: UITextField!
    @IBOutlet var className: UILabel!
    @IBOutlet var place: UILabel!
    @IBOutlet var quantity: UILabel!
    @IBOutlet var principal: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var remarks: UITextView!
    
    
    
    @IBAction func storage(_ sender: UIBarButtonItem) {
        
        refProduct = Database.database().reference()
        //取得使用者的uid
        let uid = Auth.auth().currentUser!.uid
        let email = Auth.auth().currentUser!.email
        
        //寫入的資料
        let key = refProduct.child("products").childByAutoId().key
        let product = ["product-name": productName.text!,
                       "product-class": className.text!,
                       "product-place": place.text!,
                       "product-quantity": quantity.text!,
                       "product-principal": principal.text!,
                       "product-time": time.text!,
                       "product-remarks": remarks.text!] as [String : Any]
        let childUpdates = ["/UserUid-\(uid)/products/\(key)": product]
        refProduct.updateChildValues(childUpdates)
        
        productName.text = ""
        className.text = ""
        place.text = ""
        quantity.text = ""
        principal.text = ""
        time.text = ""
        remarks.text = ""
        
        
        let alertController = UIAlertController(title: "新增貨物", message: "此筆貨物入庫完成！", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="gotoClassificaiton"{
            let nextVC = segue.destination as! Classification
            nextVC.proVC = self
        }//storyboard拉下一條segue時，在這加上else if segue.identifier=="segue的名稱"{...
        
    }
    
    
    //按背景收起鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(userUid)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


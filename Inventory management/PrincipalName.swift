//
//  PrincipalName.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/3/1.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit
import Firebase

var refPrincipalName: DatabaseReference!

class PrincipalName: UIViewController {
    
    //按背景收起鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func closePopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        print("closePopup")
    }
    @IBOutlet var newPrincipalName: UITextField!
    @IBAction func determineName(_ sender: UIButton) {
        
        //寫入的資料
        refPrincipalName = Database.database().reference()
        
        let uid = Auth.auth().currentUser!.uid
        
        
        let key = refPrincipalName.child("Principal").childByAutoId().key
        let Principal = ["principal-name": newPrincipalName.text!] as [String : Any]
        let childUpdates = ["/UserUid-\(uid)/Principal/\(key)": Principal]
        refPrincipalName.updateChildValues(childUpdates)
        
        print("UpData")
        
        self.dismiss(animated: true, completion: nil)
        
        print("determineName")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

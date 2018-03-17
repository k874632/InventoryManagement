//
//  ClassName.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/2/16.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit
import Firebase

var refClassName: DatabaseReference!

class Classname: UIViewController,UITextFieldDelegate {
    
    @IBAction func closePopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        print("closePopup")
    }
    @IBOutlet var newClassName: UITextField!
    @IBAction func determineName(_ sender: UIButton) {
        
        //寫入的資料到Firebase
        refClassName = Database.database().reference()
        
        let uid = Auth.auth().currentUser!.uid
        
        
        let key = refClassName.child("Classification").childByAutoId().key
        let Classification = ["class-name": newClassName.text!] as [String : Any]
        let childUpdates = ["/UserUid-\(uid)/Classification/\(key)": Classification]
        refClassName.updateChildValues(childUpdates)
        
        print("UpData")
        
        self.dismiss(animated: true, completion: nil)
        
        print("determineName")
    }
    
    //按確定收起鍵盤
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //點背景收起鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newClassName.delegate = self
    }
    
}


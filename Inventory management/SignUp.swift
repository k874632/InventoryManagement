//
//  Navigation.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/2/1.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit
import Firebase

var refUers: DatabaseReference!

class SignUp: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var signEmail: UITextField!
    @IBOutlet weak var signPassword: UITextField!
    @IBOutlet weak var surePassword: UITextField!
    
    //回上一頁(按鈕)
    @IBAction func pushBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //建立(按鈕)
    @IBAction func signUp(_ sender: UIButton) {
        
        
        let signEmail = self.signEmail.text
        let signPassword = self.signPassword.text
        let surePassword = self.surePassword.text
        
        //.contains確認裡面有沒有()裡的值，有的話會回傳true，沒有就回傳false
        //if !()! 是反向的動作
        if (signEmail?.isEmpty)! || !(signEmail?.contains("@"))! || !(signEmail?.contains("."))!{
            
            let alertController = UIAlertController(title: "錯誤", message: "請確認輸入電子郵件！", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        if (signPassword?.count)! < 5 {
            
            let alertController = UIAlertController(title: "錯誤", message: "密碼不得小於六位英數字", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        if (signPassword?.isEmpty)! || signPassword != surePassword{
            //
            let alertController = UIAlertController(title: "錯誤", message: "密碼不相同！請重新輸入！", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }else{
            //建立使用者（https://firebase.google.com/docs/auth/ios/start?authuser=0）
            if let email = signEmail, let password = signPassword{
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    
                    if let error = error{
                        print(error.localizedDescription)
                        
                        let alertController = UIAlertController(title: "錯誤", message: error.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    }else{
                        print("帳戶建立成功")
                        
                        let alertController = UIAlertController(title: "帳戶建立成功", message: "", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        self.signEmail.text = ""
                        self.signPassword.text = ""
                        self.surePassword.text = ""
                        
                        
                        
                        //寫入的Data
                        refUers = Database.database().reference()
                        
                        let key = refUers.child("UrersId").childByAutoId().key
                        let UrersId = ["Email": signEmail!] as [String : Any]
                        let childUpdates = ["/UrersId/\(key)": UrersId]
                        refUers.updateChildValues(childUpdates)
                        
                    }
                    
                }
            }
        }
    }
    
    //按確定收起鍵盤
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //按背景收起鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signEmail.delegate = self
        signPassword.delegate = self
        surePassword.delegate = self
    }
    
}


//
//  ViewController.swift
//  Inventory management
//
//  Created by ios on 2018/1/31.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit
import Firebase

//var refLogin: DatabaseReference!

class ViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func signIn(_ sender: UIButton) {
        
        let login = self.login.text
        let password = self.password.text
        
        if (login?.isEmpty)! || !(login?.contains("@"))! || !(login?.contains("."))!{
            let alertController = UIAlertController(title: "登入失敗", message: "請確認帳號後再重新輸入！", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            return
        }
        
        if (password?.isEmpty)! || (password?.count)! <= 5{
            let alertController = UIAlertController(title: "登入失敗", message: "請確認密碼後再重新輸入！", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            return
        }
        
        
        //登入
        Auth.auth().signIn(withEmail: login!, password: password!) { (user, error) in
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                let uid = user.uid
                let email = user.email!
                
                
                print("使用者的uid：\(uid)")
                print("使用者的email：\(email)")
                print("登入成功")
                
                
            }else{
                let alertController = UIAlertController(title: "登入失敗", message: "請確認後再次登入！", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                print("登入失敗")
            }
        }
        
    }
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
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
        
        login.delegate = self
        password.delegate = self
    }
    
    
}



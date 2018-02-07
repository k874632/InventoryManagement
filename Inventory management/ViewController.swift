//
//  ViewController.swift
//  Inventory management
//
//  Created by ios on 2018/1/31.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var remind: UILabel!
    @IBAction func signIn(_ sender: UIButton) {
        
        let login = self.login.text
        let password = self.password.text
        
        if (login?.isEmpty)! || !(login?.contains("@"))! || !(login?.contains("."))!{
            remind.text = "請確認帳號後再重新輸入！"
            return
        }
        
        if (password?.isEmpty)! || (password?.count)! <= 5{
            remind.text = "請確認密碼後再重新輸入！"
            return
        }
        
        
        //登入
        Auth.auth().signIn(withEmail: login!, password: password!) { (user, error) in
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                _ = user.uid
                _ = user.email
                self.remind.text = ""
                print("登入成功")
                
                let TabBar = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
                self.navigationController?.pushViewController(TabBar!, animated: true)
            }else{
                self.remind.text = "登入失敗！請確認後再輸入一次！"
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


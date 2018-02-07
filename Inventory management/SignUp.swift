//
//  Navigation.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/2/1.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit
import Firebase

class SignUp: UIViewController {
    //測試GitHub
    @IBOutlet weak var remind: UILabel!
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
            remind.text = "請確認輸入電子郵件！"
            return
        }
        
        if (signPassword?.isEmpty)! || signPassword != surePassword{
            remind.text = "密碼不相同！請重新輸入！"
            if (signPassword?.count)! < 5 {
                remind.text = "密碼不得小於6的字數！"
                return
            }
        }else{
            remind.text = ""
            //建立使用者（https://firebase.google.com/docs/auth/ios/start?authuser=0）
            Auth.auth().createUser(withEmail: signEmail!, password: signPassword!) { (user, error) in
                print("帳號建立成功")
                if let error = error{
                    print(error.localizedDescription)
                }
            }
            //跳到登入帳號頁面
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "VC")
            self.navigationController?.pushViewController(VC!, animated: true)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

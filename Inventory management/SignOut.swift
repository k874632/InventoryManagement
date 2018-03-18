//
//  VC5.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/2/3.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit

class SignOut: UIViewController {
    
    @IBAction func signOut(_ sender: UIButton) {
//        let vcLogin = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")as! ViewController
        self.navigationController?.popToRootViewController(animated: true)
        print("返回登入畫面")
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

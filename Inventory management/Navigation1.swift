//
//  Navigation1.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/2/20.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit

class Navigation1: UINavigationController {
    
    var userUid:String = ""
    
    
    override func viewDidLoad() {
        
        let NewProduct = self.storyboard?.instantiateViewController(withIdentifier: "NewProduct") as! NewProduct
        
        NewProduct.userUid = userUid
        
        self.present(NewProduct, animated: true, completion: nil)
        
        super.viewDidLoad()
        print(userUid)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}

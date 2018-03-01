//
//  Quantity.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/2/28.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit

class Quantity: UIViewController {
    
    
    var proVC:NewProduct!
    
    @IBAction func closePopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        print("closePopup")
    }
    @IBOutlet var quantityTFD: UITextField!
    @IBAction func Stepper(_ sender: UIStepper) {
        quantityTFD.text = String(Int(sender.value))
    }
    @IBAction func determineQty(_ sender: UIButton) {
        proVC.quantity.text = quantityTFD.text
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //按背景收起鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

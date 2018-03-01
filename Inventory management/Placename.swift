//
//  VC4.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/2/3.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit
import Firebase

var refPlaceName: DatabaseReference!

class Placename: UIViewController {
    
    //按背景收起鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func closePopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        print("closePopup")
    }
    @IBOutlet var newPlaceName: UITextField!
    @IBAction func determineName(_ sender: UIButton) {
        
        //寫入的資料
        refPlaceName = Database.database().reference()
        
        let uid = Auth.auth().currentUser!.uid
        
        
        let key = refPlaceName.child("Place").childByAutoId().key
        let Place = ["place-name": newPlaceName.text!] as [String : Any]
        let childUpdates = ["/UserUid-\(uid)/Place/\(key)": Place]
        refPlaceName.updateChildValues(childUpdates)
        
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

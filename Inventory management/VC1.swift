//
//  VC1.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/2/3.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit

class TEDCell1:UITableViewCell{
    @IBOutlet var label1: UILabel!
    @IBOutlet var txt1: UITextField!
    
}

class TEDCell2:UITableViewCell{
    @IBOutlet var label1: UILabel!
    
}

class TEDCell3:UITableViewCell{
    
}

class VC1: UIViewController,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell:UITableViewCell!
        if indexPath.row == 1{
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell1")
        }else if indexPath.row == 2{
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell2")
        }
        return cell
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

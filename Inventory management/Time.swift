//
//  time.swift
//  Inventory management
//
//  Created by 王奇達 on 2018/3/1.
//  Copyright © 2018年 Nick. All rights reserved.
//

import UIKit

class Time: UIViewController {
    
    var proVC:NewProduct!
    
    @IBAction func closePopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        print("closePopup")
    }
    @IBOutlet var dateField: UITextField!
    
    @IBOutlet var timeField: UITextField!
    
    @IBAction func determineTime(_ sender: UIButton) {
        proVC.time.text = "\(dateField.text!) \(timeField.text!)"
        self.dismiss(animated: true, completion: nil)
    }
    
    let picker = UIDatePicker()
    let pickerTime = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        createTimePicker()
        
        
        
    }
    
    func createDatePicker(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([done], animated: false)
        
        dateField.inputAccessoryView = toolBar
        dateField.inputView = picker
        
        picker.datePickerMode = .date
    }
    
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.dateFormat = "YYYY-MM-dd"
        let dateString = formatter.string(from: picker.date)
        
        dateField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    func createTimePicker(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedForTime))
        toolBar.setItems([done], animated: false)
        
        timeField.inputAccessoryView = toolBar
        timeField.inputView = pickerTime
        
        pickerTime.datePickerMode = .time
    }
    
    @objc func donePressedForTime(){
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: pickerTime.date)
        
        timeField.text = "\(timeString)"
        self.view.endEditing(true)
    }
    
    //按背景收起鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

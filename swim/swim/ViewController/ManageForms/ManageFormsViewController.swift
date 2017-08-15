//
//  AskOrder.swift
//  swim
//
//  Created by qing class on 2017/7/5.
//  Copyright © 2017年 qing class. All rights reserved.
//

import UIKit

class ManageFormsViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet var DateFromTextField:UITextField!
    @IBOutlet var DateToTextField:UITextField!
    @IBOutlet var EmailTextField:UITextField!

    var dpicker:UIDatePicker!
    var toolBar:UIToolbar!
    var course: CourseModel!
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        pickerData = ["游泳", "理论"]
        // Connect data
        dpicker = UIDatePicker(frame: CGRect(x:0, y:200, width:view.frame.width,height:300))
        dpicker.backgroundColor = .white
        dpicker.addTarget(self, action: #selector(ManageFormsViewController.handleDatePicker(sender:)), for: UIControlEvents.valueChanged)
        dpicker.locale = Locale(identifier: "zh_CN")
        dpicker.tag = 0
        toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "确认", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ManageFormsViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ManageFormsViewController.cancelPicker))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        DateFromTextField.inputView = dpicker
        DateFromTextField.inputAccessoryView = toolBar
        DateToTextField.inputView = dpicker
        DateToTextField.inputAccessoryView = toolBar
        DateFromTextField.delegate = self
        DateToTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        if(sender.tag == 101){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            DateFromTextField.text = dateFormatter.string(from: sender.date)
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            DateToTextField.text = dateFormatter.string(from: sender.date)
        }
    }
    
    
    func cancelPicker() {
        if DateFromTextField.isFirstResponder{
            DateFromTextField.resignFirstResponder()
        }
        if DateToTextField.isFirstResponder{
            DateToTextField.resignFirstResponder()
        }

    }
    
    func donePicker() {
        if dpicker.tag != 0 {
            handleDatePicker(sender: dpicker)
        }
        cancelPicker()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField === DateFromTextField){
            dpicker.datePickerMode = .time
            dpicker.tag = 101
        }else if(textField === DateToTextField){
            dpicker.datePickerMode = .time
            dpicker.tag = 102
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        dpicker.tag = 0
    }
    
    
    @IBAction func tapSubmitButton(_ sender: Any) {
        if self.DateFromTextField.text == "" {
            Tools.showTap(message: "请输入时间", superVC: self)
            return
        }
        
        if self.DateToTextField.text == "" {
            Tools.showTap(message: "请输入时间", superVC: self)
            return
        }
        
        if self.EmailTextField.text == "" {
            Tools.showTap(message: "请输入邮箱", superVC: self)
            return
        }

        ManageCourseRequest(start: {
        }, success: { (result) in
            DispatchQueue.main.async {
//              Tools.showTap(message:result as! String, superVC: self)
            }
            
        }) { (errorMessage) in
            DispatchQueue.main.async {
                Tools.showTap(message: errorMessage, superVC: self)
            }
        }.exportForm(From:self.DateFromTextField.text!,To:self.DateToTextField.text!,Email:self.EmailTextField.text!)
    }
}

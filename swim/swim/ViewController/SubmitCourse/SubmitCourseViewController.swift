//
//  AskOrder.swift
//  swim
//
//  Created by qing class on 2017/7/5.
//  Copyright © 2017年 qing class. All rights reserved.
//

import UIKit

class SubmitCourseViewController: UIViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate{
    
    @IBOutlet var DateTextField:UITextField!
    @IBOutlet var DateFromTextField:UITextField!
    @IBOutlet var DateToTextField:UITextField!
    @IBOutlet var TypeTextField:UITextField!
    
    @IBOutlet var TeacherNameField:UITextField!
    @IBOutlet var StudentsNumberField:UITextField!
    @IBOutlet var StudentsNamesField:UITextView!

    var dpicker:UIDatePicker!
    var tpicker:UIPickerView!
    var toolBar:UIToolbar!
    var selectIndex:Int = 0
    var course: CourseModel!
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        pickerData = ["游泳", "理论"]
        // Connect data
        tpicker = UIPickerView(frame: CGRect(x:0, y:200, width:view.frame.width,height:300))
        tpicker.backgroundColor = .white
        tpicker.showsSelectionIndicator = true
        tpicker.delegate = self
        tpicker.dataSource = self 
        dpicker = UIDatePicker(frame: CGRect(x:0, y:200, width:view.frame.width,height:300))
        dpicker.backgroundColor = .white
        dpicker.addTarget(self, action: #selector(SubmitCourseViewController.handleDatePicker(sender:)), for: UIControlEvents.valueChanged)
        dpicker.locale = Locale(identifier: "zh_CN")
        dpicker.tag = 0
        toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "确认", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SubmitCourseViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SubmitCourseViewController.cancelPicker))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        DateTextField.inputView = dpicker
        DateTextField.inputAccessoryView = toolBar
        DateFromTextField.inputView = dpicker
        DateFromTextField.inputAccessoryView = toolBar
        DateToTextField.inputView = dpicker
        DateToTextField.inputAccessoryView = toolBar
        DateTextField.delegate = self
        DateFromTextField.delegate = self
        DateToTextField.delegate = self
        TypeTextField.inputView = tpicker
        TypeTextField.inputAccessoryView = toolBar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        if (sender.tag == 100) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            DateTextField.text = dateFormatter.string(from: sender.date)
        }else if(sender.tag == 101){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            DateFromTextField.text = dateFormatter.string(from: sender.date)
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            DateToTextField.text = dateFormatter.string(from: sender.date)
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectIndex = row;
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        TypeTextField.text = pickerData[row]
    }
    
    func cancelPicker() {
        if DateTextField.isFirstResponder{
            DateTextField.resignFirstResponder()
        }
        if DateFromTextField.isFirstResponder{
            DateFromTextField.resignFirstResponder()
        }
        if DateToTextField.isFirstResponder{
            DateToTextField.resignFirstResponder()
        }
        if TypeTextField.isFirstResponder{
            TypeTextField.resignFirstResponder()
        }
    }
    
    func donePicker() {
        if dpicker.tag != 0 {
            handleDatePicker(sender: dpicker)
        }else{
            TypeTextField.text = pickerData[selectIndex]
        }
        cancelPicker()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField === DateTextField) {
            dpicker.datePickerMode = .date
            dpicker.tag = 100
        }else if(textField === DateFromTextField){
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
        if self.DateTextField.text == "" {
            Tools.showTap(message: "请输入日期", superVC: self)
            return
        }
        
        if self.DateFromTextField.text == "" {
            Tools.showTap(message: "请输入时间", superVC: self)
            return
        }
        
        if self.DateToTextField.text == "" {
            Tools.showTap(message: "请输入时间", superVC: self)
            return
        }

        if self.TeacherNameField.text == "" {
            Tools.showTap(message: "请输入老师姓名", superVC: self)
            return
        }

        if self.StudentsNumberField.text == "" {
            Tools.showTap(message: "请输入学生人数", superVC: self)
            return
        }
        
        if self.StudentsNamesField.text == "" {
            Tools.showTap(message: "请输入学生姓名", superVC: self)
            return
        }

        if self.TypeTextField.text == "" {
            Tools.showTap(message: "请输入课程类型", superVC: self)
            return
        }
        
        if self.course == nil {
            self.course = CourseModel()
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.course.SchoolDate = dateFormatter.date(from: self.DateTextField.text!)
        self.course.SchoolTime = self.DateFromTextField.text!+"-"+self.DateToTextField.text!
        self.course.TeacherName = self.TeacherNameField.text!
        self.course.StudentsNumber = Int(self.StudentsNumberField.text!)
        self.course.StudentsNames = self.StudentsNamesField.text!
        self.course.CourseType = selectIndex == 0 ? .Theory : .SwimmingPool
        self.course.CourseStatus = .Order
        
        CourseRequest(start: {
        }, success: { (result) in
            DispatchQueue.main.async {
                Tools.showTap(message:result as! String, superVC: self)
            }
            
        }) { (errorMessage) in
            DispatchQueue.main.async {
                Tools.showTap(message: errorMessage, superVC: self)
            }
        }.CourseAdd(model:self.course)
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

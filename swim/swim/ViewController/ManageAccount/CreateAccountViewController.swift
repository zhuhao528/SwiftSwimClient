//
//  CreateAccountViewController.swift
//  swim
//
//  Created by qing class on 2017/7/13.
//  Copyright © 2017年 qing class. All rights reserved.
//

import UIKit


/// 当前页面类型
///
/// - CreateAccount: 创建账号
/// - ChangePassword: 修改密码
enum VCType {
    case CreateAccount
    case ChangePassword
    
    /// 页面Title
    ///
    /// - Returns: 页面title
    public func description() -> String {
        switch self {
        case .CreateAccount:
            return "创建账号"
        case .ChangePassword:
            return "修改密码"
        }
    }
}

class CreateAccountViewController: UIViewController {
    
    @IBOutlet var TeacherNameField:UITextField!
    @IBOutlet var AccountField:UITextField!
    @IBOutlet var PasswordField:UITextField!
    @IBOutlet var RePasswordField:UITextField!
    @IBOutlet var submitButton: UIButton!

    var userInfo: UserModel!
    var vcType: VCType = .CreateAccount
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 配置当前VC
    private func configVC() {
        if userInfo != nil {
            if userInfo.userId == "" {
                self.vcType = VCType.CreateAccount
                TeacherNameField.placeholder = "请输入教练姓名"
                AccountField.placeholder = "请输入账号"
                PasswordField.placeholder = "请输入密码"
                RePasswordField.placeholder = "请输入重复秘密"
            } else {
                self.vcType = VCType.ChangePassword
                TeacherNameField.text = userInfo.userName
                AccountField.text = userInfo.account
                PasswordField.text = userInfo.password!
                RePasswordField.text = userInfo.password
            }
            self.title = self.vcType.description()
            submitButton .setTitle( self.vcType.description(), for: UIControlState.normal)
            submitButton .setTitle( self.vcType.description(), for: UIControlState.highlighted)
        }
    }
    
    @IBAction func tapSubmitButton(_ sender: Any) {
        if self.TeacherNameField.text == "" {
            Tools.showTap(message: "请输入教练姓名", superVC: self)
            return
        }
        
        if self.AccountField.text == "" {
            Tools.showTap(message: "请输入账号", superVC: self)
            return
        }
        
        if self.PasswordField.text == "" {
            Tools.showTap(message: "请输入密码", superVC: self)
            return
        }
        
        if self.RePasswordField.text == "" {
            Tools.showTap(message: "请输入重复密码", superVC: self)
            return
        }
        
        if (self.RePasswordField.text  != self.PasswordField.text) {
            Tools.showTap(message: "密码输入不一致", superVC: self)
            return
        }
        
        switch vcType {
        case .CreateAccount:
            let model:UserModel = UserModel()
            model.userName = TeacherNameField.text
            model.account = AccountField.text
            model.password = PasswordField.text!
            model.authority = .Ordinary
            UserInfoRequest(start: {
            }, success: { (result) in
                DispatchQueue.main.async {
                    Tools.showTap(message:"注册成功", superVC: self)
                }
                
            }) { (errorMessage) in
                DispatchQueue.main.async {
                    Tools.showTap(message: errorMessage, superVC: self)
                }
            }.register(model:model)
        case .ChangePassword:
            let model:UserModel = UserModel()
            model.userId = userInfo.userId
            model.userName = TeacherNameField.text
            model.account = AccountField.text
            model.password = PasswordField.text!
            model.authority = userInfo.authority
            UserInfoRequest(start: {
            }, success: { (result) in
                DispatchQueue.main.async {
                    Tools.showTap(message:"注册成功", superVC: self)
                }
            }) { (errorMessage) in
                DispatchQueue.main.async {
                    Tools.showTap(message: errorMessage, superVC: self)
                }
            }.changePassword(model:model)
        }
    }
}
